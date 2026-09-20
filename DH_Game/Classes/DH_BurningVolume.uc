//==============================================================================
// Darkest Hour: Europe '44-'45
// Copyright (c) Darklight Games.  All rights reserved.
//==============================================================================
// Before deleting this class, a maintainer with the map packages must confirm
// that no map still references it: open every package under
// DarkestHourDev/Maps in the SDK and check its actor list, or dump each .rom
// name table and search for "DH_BurningVolume". Map packages bind actor
// classes by name at load time, so a map that still references this class
// fails to load once the class is gone, and that cannot be established from
// the source tree alone. Convert any map that still uses it to DHBurningVolume
// and re-save that map first.
//==============================================================================

class DH_BurningVolume extends DHBurningVolume // just a legacy class for backwards compatibility, as DHBurningVolume is now in DH_Engine code package
    placeable;
    // NOTE: making this actor notplacable would not result in it being deleted from maps when rebuilt, but would stop it being added
/*
simulated function PostBeginPlay()
{
    super.PostBeginPlay();

    if (Role == ROLE_Authority)
    {
        Log("Leveller, please replace DH_BurningVolume actors with DHBurningVolume, as this is a temporary legacy actor & in future the map will break", 'MAP WARNING');
    }
}
*/
