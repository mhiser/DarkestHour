//==============================================================================
// Darkest Hour: Europe '44-'45
// Copyright (c) Darklight Games.  All rights reserved.
//==============================================================================

class DH_SatchelCharge10lb10sWeapon extends DHExplosiveWeapon;

defaultproperties
{
    ItemName="3KG Satchel Charge"
    FireModeClass(0)=Class'DH_SatchelCharge10lb10sFire'
    AttachmentClass=Class'DH_SatchelCharge10lb10sAttachment'
    PickupClass=Class'DH_SatchelCharge10lb10sPickup'

    InventoryGroup=7
    GroupOffset=2
    Priority=2

    // The fuze length is read here, seeded into DHExplosiveWeapon.CurrentFuzeTime & passed to the
    // thrown charge by DHThrownExplosiveFire.SpawnProjectile, so it burns down while the charge is held

    Mesh=SkeletalMesh'Common_Satchel_1st.Sachel_Charge'
    Skins(2)=Texture'Weapons1st_tex.SatchelCharge'

    PlayerViewOffset=(X=10.0,Y=5.0,Z=0.0)

    FuzeLengthRange=(Min=15.0,Max=15.0)
    PreFireHoldAnim="Weapon_Down"
}
