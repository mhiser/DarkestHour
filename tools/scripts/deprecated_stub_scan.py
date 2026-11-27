"""Report which DHDeprecated stub classes the shipped maps still import.

A DHDeprecated stub may be deleted only when no map imports it.
See the retirement rule in DH_Engine/Classes/DHDeprecated.uc.

The script reads the import table of each map package (.rom). A class counts
as used only when a map imports it as a class (Core.Class). It then checks
that nothing else in the source tree names the class.

Usage:
    python tools/scripts/deprecated_stub_scan.py MAPS_DIR [MORE_MAPS_DIRS]

Pass every directory that holds shipped maps, for example
DarkestHourDev/Maps (after "git lfs pull") and the DarkestHour/Maps folder of
a Steam install. When a map is in more than one directory, the first one wins.
Git LFS pointer files are skipped. The script exits with code 1 if a map fails
to parse.
"""

import re
import struct
import subprocess
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parents[2]
# Red Orchestra packages carry 0x9E2A83C2. Stock Unreal packages carry 0x9E2A83C1.
PACKAGE_TAGS = (0x9E2A83C1, 0x9E2A83C2)
STUB_PATTERN = re.compile(r'^class\s+(\w+)\s+extends\s+(\w+)', re.IGNORECASE | re.MULTILINE)


def read_index(data, pos):
    """Read an Unreal compact index. Return (value, new position)."""
    b = data[pos]
    pos += 1
    negative = b & 0x80
    value = b & 0x3F
    shift = 6
    more = b & 0x40
    while more:
        b = data[pos]
        pos += 1
        value |= (b & 0x7F) << shift
        shift += 7
        more = b & 0x80
    return (-value if negative else value), pos


def class_imports(path):
    """Return the set of 'Package.Class' names that a package imports as classes."""
    data = path.read_bytes()
    tag, version, _licensee, _flags, name_count, name_offset, _export_count, _export_offset, import_count, import_offset = \
        struct.unpack_from('<IHHIIIIIII', data, 0)
    if tag not in PACKAGE_TAGS:
        raise ValueError('not an Unreal package')

    names = []
    pos = name_offset
    for _ in range(name_count):
        if version >= 64:
            length, pos = read_index(data, pos)
            names.append(data[pos:pos + length - 1].decode('latin-1'))
            pos += length
        else:
            end = data.index(b'\0', pos)
            names.append(data[pos:end].decode('latin-1'))
            pos = end + 1
        pos += 4  # name flags

    imports = []
    pos = import_offset
    for _ in range(import_count):
        _class_package, pos = read_index(data, pos)
        class_name, pos = read_index(data, pos)
        outer = struct.unpack_from('<i', data, pos)[0]
        pos += 4
        object_name, pos = read_index(data, pos)
        imports.append((names[class_name], outer, names[object_name]))

    result = set()
    for class_name, outer, object_name in imports:
        if class_name.lower() == 'class' and outer < 0:
            result.add(f'{imports[-outer - 1][2]}.{object_name}'.lower())
    return result


def find_stubs():
    """Return {'Package.Class': path} for every class that extends DHDeprecated, directly or not."""
    parents = {}
    paths = {}
    for path in REPO.glob('*/Classes/*.uc'):
        match = STUB_PATTERN.search(path.read_text(encoding='latin-1'))
        if match:
            parents[match.group(1).lower()] = match.group(2).lower()
            paths[match.group(1).lower()] = path

    def is_stub(name):
        seen = set()
        while name in parents and name not in seen:
            seen.add(name)
            name = parents[name]
            if name == 'dhdeprecated':
                return True
        return False

    return {f'{path.parts[-3]}.{path.stem}': path for name, path in paths.items() if is_stub(name)}


def source_references(class_name, own_path):
    """Return tracked text files, other than the class itself, that name the class."""
    output = subprocess.run(['git', 'grep', '-I', '-l', '-w', '-i', class_name, '--', '.', ':!DarkestHourDev/Maps'],
                            cwd=REPO, capture_output=True, text=True).stdout
    own = own_path.relative_to(REPO).as_posix()
    return [line for line in output.splitlines() if line != own]


def main(argv):
    if not argv:
        print(__doc__)
        return 2

    # Use the first real package found for each map name.
    # A Git LFS pointer file is not a package, so it is skipped.
    maps = {}
    for folder in argv:
        for path in sorted(Path(folder).glob('*.rom')):
            with path.open('rb') as file:
                header = file.read(4)
            is_package = len(header) == 4 and struct.unpack('<I', header)[0] in PACKAGE_TAGS
            if is_package:
                maps.setdefault(path.name.lower(), path)
    used = {}
    failed = False
    level_info_maps = 0
    for path in maps.values():
        try:
            imported = class_imports(path)
        except (ValueError, IndexError, struct.error) as error:
            print(f'FAILED  {path}: {error}')
            failed = True
            continue
        if 'dh_engine.dh_levelinfo' in imported:
            level_info_maps += 1
        for name in imported:
            used.setdefault(name, []).append(path.stem)

    # Sanity check: almost every playable map imports DH_LevelInfo.
    print(f'Scanned {len(maps)} maps. {level_info_maps} import DH_Engine.DH_LevelInfo.')

    stubs = find_stubs()
    importers = {name: sorted(used.get(name.lower(), [])) for name in stubs}
    references = {name: source_references(path.stem, path) for name, path in stubs.items()}

    # A reference from another stub that is itself deleted does not count.
    # Repeat until the set of deletable stubs stops shrinking.
    deletable = {name for name in stubs if not importers[name]}
    changed = True
    while changed:
        deletable_paths = {stubs[name].relative_to(REPO).as_posix() for name in deletable}
        keep = {name for name in deletable if any(ref not in deletable_paths for ref in references[name])}
        changed = bool(keep)
        deletable -= keep

    for name in sorted(stubs):
        if name in deletable:
            print(f'DELETE  {name}')
        elif importers[name]:
            print(f'KEEP    {name} (maps: {", ".join(importers[name])})')
        else:
            print(f'KEEP    {name} (source: {", ".join(references[name])})')

    print(f'{len(deletable)} of {len(stubs)} stubs can be deleted.')
    return 1 if failed else 0


if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]))
