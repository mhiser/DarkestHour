//==============================================================================
// Darkest Hour: Europe '44-'45
// Copyright (c) Darklight Games.  All rights reserved.
//==============================================================================
// Before deleting this class, a maintainer with the map packages must confirm
// that no map still references it: open every package under
// DarkestHourDev/Maps in the SDK and check its actor list, or dump each .rom
// name table and search for "DH_Stug3GFactory_SnowTwo". Map packages bind
// actor classes by name at load time, so a map that still references this
// class fails to load once the class is gone, and that cannot be established
// from the source tree alone. Convert any map that still uses it to
// DH_Stug3GFactory_Late_Snow and re-save that map first.
//==============================================================================

class DH_Stug3GFactory_SnowTwo extends DH_Stug3GFactory_Late_Snow // just a legacy class for backwards compatibility, as SnowTwo version was renamed to Late_Snow
    notplaceable;

simulated function PostBeginPlay()
{
    super.PostBeginPlay();

    if (Role == ROLE_Authority)
    {
        Log("Leveller, please replace DH_Stug3GFactory_SnowTwo with DH_Stug3GFactory_Late_Snow, as this is a temporary legacy actor & in future the map will break", 'MAP WARNING');
    }
}
