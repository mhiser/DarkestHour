//==============================================================================
// Darkest Hour: Europe '44-'45
// Copyright (c) Darklight Games.  All rights reserved.
//==============================================================================
// Do not delete this class yet. An import-table scan of the 202 map packages
// under DarkestHourDev/Maps (issue #42) found 18 maps that import it, with
// 90 placed actors in total. Map packages bind classes by name at load
// time, so these maps fail to load if this class is gone. Replace each actor
// with DHWaterVolume and re-save the map before you delete this class.
// The scan does not cover community maps outside the repo.
//==============================================================================

class DH_WaterVolume extends DHWaterVolume // just a legacy class for backwards compatibility, as DHWaterVolume is now in DH_Engine code package (necessary for the build order)
    placeable;
    // NOTE: making this actor notplacable would not result in it being deleted from maps when rebuilt, but would stop it being added
/*
simulated function PostBeginPlay()
{
    super.PostBeginPlay();

    if (Role == ROLE_Authority)
    {
        Log("Leveller, please replace DH_WaterVolume actors with DHWaterVolume, as this is a temporary legacy actor & in future the map will break", 'MAP WARNING');
    }
}
*/
