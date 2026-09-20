//==============================================================================
// Darkest Hour: Europe '44-'45
// Copyright (c) Darklight Games.  All rights reserved.
//==============================================================================
// Revolvers are loaded one round at a time, and the one-round-at-a-time reload
// is implemented in DHBoltActionWeapon, not in DHProjectileWeapon: the
// EReloadState machine, PlayPreReload / PlaySingleReload / PlayPostReload,
// SetSingleReloadTimer, GetRoundsToLoad, PerformReload and GiveBackAmmo all
// live there. So a revolver extends the bolt action class and then switches off
// the bolt with bShouldSkipBolt.
//
// This class can only go away once that reload state machine is moved up into
// DHProjectileWeapon. Note that it is also an animation category in its own
// right: DHPawn tests IsA('DHRevolverWeapon') next to IsA('DHPistolWeapon') when
// picking put-away and swap animations, so those tests have to be retargeted
// as part of any such move.
//==============================================================================

class DHRevolverWeapon extends DHBoltActionWeapon
    abstract;

defaultproperties
{
    SwayModifyFactor=1.1 // More sway for pistols
    BobModifyFactor=0.2  // Less weapon bob for pistols

    bCanAttachOnBack=false
    InventoryGroup=3
    Priority=5
    FreeAimRotationSpeed=8.0
    AIRating=0.35
    CurrentRating=0.35
    bSniping=false
    bUsesIronsightFOV=false

    bShouldSkipBolt=true
    bCanUseUnfiredRounds=false
}
