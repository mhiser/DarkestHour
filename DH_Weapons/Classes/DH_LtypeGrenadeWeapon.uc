//==============================================================================
// Darkest Hour: Europe '44-'45
// Copyright (c) Darklight Games.  All rights reserved.
//==============================================================================

class DH_LTypeGrenadeWeapon extends DHExplosiveWeapon;

defaultproperties
{
    ItemName="O.T.O Tipo L Anti-Tank Grenade"
    FireModeClass(0)=Class'DH_LTypeGrenadeFire'
    FireModeClass(1)=Class'DH_LTypeGrenadeFire' // no toss fire because it would be utterly useless
    AttachmentClass=Class'DH_LTypeGrenadeAttachment'
    PickupClass=Class'DH_LTypeGrenadePickup'
    Mesh=SkeletalMesh'DH_Ltype_anm.Ltype_1st'
    GroupOffset=4
    DisplayFOV=80.0
    // bHasReleaseLever is the flag for "this explosive is not primed while it is
    // held". DHThrownExplosiveFire.ModeHoldFire only sets bPrimed when the flag is
    // false, and ModeTick only runs the fuze down (and finally throws the grenade
    // out of the player's hand and kills him) while bPrimed is true. The Tipo L has
    // an impact fuze, so it must never cook off in the hand. The SRCM mod. 35, the
    // other impact grenade, sets the flag for the same reason.
    bHasReleaseLever=true
}