//==============================================================================
// Darkest Hour: Europe '44-'45
// Copyright (c) Darklight Games.  All rights reserved.
//==============================================================================
// Do not delete this class yet. An import-table scan of the 202 map packages
// under DarkestHourDev/Maps (issue #42) found 30 maps that import it, with
// 140 placed actors in total. Map packages bind classes by name at load
// time, so these maps fail to load if this class is gone. Replace each actor
// with DHBurningVolume and re-save the map before you delete this class.
// The scan does not cover community maps outside the repo.
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
