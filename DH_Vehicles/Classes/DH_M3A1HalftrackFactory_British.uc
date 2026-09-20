//==============================================================================
// Darkest Hour: Europe '44-'45
// Copyright (c) Darklight Games.  All rights reserved.
//==============================================================================

// LEGACY class for backwards compatibility as there's no longer any separate vehicle skin with British markings
// The new (from DH v8.0) M3 halftrack skin is generic, with allies markings but not nation or unit specific decals
// Before deleting this class, a maintainer with the map packages must confirm
// that no map still references it: open every package under
// DarkestHourDev/Maps in the SDK and check its actor list, or dump each .rom
// name table and search for "DH_M3A1HalftrackFactory_British". Map packages
// bind actor classes by name at load time, so a map that still references this
// class fails to load once the class is gone, and that cannot be established
// from the source tree alone. Convert any map that still uses it to
// DH_M3A1HalftrackFactory and re-save that map first.

class DH_M3A1HalftrackFactory_British extends DH_M3A1HalftrackFactory;

simulated function PostBeginPlay()
{
    super.PostBeginPlay();

    if (Role == ROLE_Authority)
    {
        Log("Leveller, please replace use of DH_M3A1HalftrackFactory_British with DH_M3A1HalftrackFactory, as this is a temporary legacy actor & in future the map will break", 'MAP WARNING');
    }
}
