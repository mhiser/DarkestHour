//==============================================================================
// Darkest Hour: Europe '44-'45
// Copyright (c) Darklight Games.  All rights reserved.
//==============================================================================

class DH_RPG43GrenadeWeapon extends DHExplosiveWeapon;

defaultproperties
{
    ItemName="RPG-43 Anti-Tank Grenade"
    NativeItemName="RPG-43"
    FireModeClass(0)=Class'DH_RPG43GrenadeFire'
    FireModeClass(1)=Class'DH_RPG43GrenadeFire' // no toss fire because it would be utterly useless
    AttachmentClass=Class'DH_RPG43GrenadeAttachment'
    PickupClass=Class'DH_RPG43GrenadePickup'
    Mesh=SkeletalMesh'DH_RPG_1st.RPG43Grenade'
    Skins(2)=Texture'DH_Weapon_tex.RPG43Grenade' // TODO: there's no specular mask for this weapon

    GroupOffset=4
    DisplayFOV=80.0
    // Impact fuze, so the grenade must not be primed while it is held. Without
    // the flag, DHThrownExplosiveFire.ModeHoldFire primes it and ModeTick cooks it
    // off in the player's hand. See DH_LtypeGrenadeWeapon for the full mechanism.
    bHasReleaseLever=true
}
