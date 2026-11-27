//==============================================================================
// Darkest Hour: Europe '44-'45
// Copyright (c) Darklight Games.  All rights reserved.
//==============================================================================

// Map actors whose class is retired are reparented to this class. The class
// name still resolves when a map loads, and the actor does nothing.
//
// Retirement rule for stubs (classes that extend DHDeprecated):
//
// 1. A stub stays while any shipped map imports it.
// 2. A stub may be deleted when no shipped map imports it as a class and
//    nothing else in the source tree names it.
// 3. The developer who deletes a stub runs the check below first.
//    The reviewer confirms that the commit message carries the scan result.
// 4. Run the check before each release. Delete every stub that passes it.
// 5. List the deleted stubs in the release notes. Community maps outside
//    this repo are not scanned, so their authors must convert those actors.
//
// The check reads the import table of every map:
//
//     git lfs pull --include="DarkestHourDev/Maps/*"
//     python tools/scripts/deprecated_stub_scan.py DarkestHourDev/Maps
//
// To include the maps of a Steam install, add its DarkestHour/Maps folder as
// a second argument. Never delete a stub that the script marks KEEP.
// To retire a stub that maps still import, convert the actors in those maps
// first. Then run the check again.

class DHDeprecated extends Note
    notplaceable;

defaultproperties
{
    Text="This actor is deprecated and should be removed."
}
