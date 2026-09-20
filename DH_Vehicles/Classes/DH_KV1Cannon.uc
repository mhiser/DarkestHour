//==============================================================================
// Darkest Hour: Europe '44-'45
// Copyright (c) Darklight Games.  All rights reserved.
//==============================================================================

// Unfinished and currently unreachable: the only reference to this gun is in
// DH_KV1Tank, which extends DHDeprecated with its defaultproperties commented
// out, and no KV-1 (non-E) record exists in DHVehicleRegistry.
class DH_KV1Cannon extends DH_KV1ECannon;

defaultproperties
{
    // Turret mesh
    Mesh=SkeletalMesh'DH_KV_1and2_anm.KV1b_turret_ext'
    Skins(0)=Texture'DH_VehiclesSOV_tex.KV1_body_ext'  //to be replaced with new skin that doesnt have armor shields
    Skins(1)=Texture'DH_VehiclesSOV_tex.KV1_turret_int'

    // Turret armor
    FrontArmorFactor=7.7 //front turret armor has complex shape: it combines spherical 90mm detail and small areas of flat 75mm armor. Unfortunately there is no way to realistically portray it in one value
    LeftArmorFactor=7.5
    RightArmorFactor=7.5
    RearArmorFactor=7.5
    LeftArmorSlope=15.0
    FrontArmorSlope=20.0
    RightArmorSlope=15.0
    RearArmorSlope=15.0
    FrontLeftAngle=330.0
    FrontRightAngle=30.0
    RearRightAngle=138.0
    RearLeftAngle=222.0


}
