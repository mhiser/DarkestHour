//==============================================================================
// Darkest Hour: Europe '44-'45
// Copyright (c) Darklight Games.  All rights reserved.
//==============================================================================
// This weapon goes by many names:
// - Wz. 35
// - Panzerbüchse Modell 1935
// - Fucile Controcarro 35(p)
//
// It is a Polish anti-tank rifle that was used by the Germans after the invasion
// of Poland, where it was captured in large numbers.
//
// The Germans gave around 630 of these rifles to the Italians, who used them
// under the designation "Fucile Controcarro 35(p)".
//
// The Germans upgraded the projectile by reloading it with a tungsten core. This
// increased the muzzle velocity to 1295 m/s. This allegedly boosted the penetration,
// but we've found no numbers to back this up. Therefore, we're using the penetration
// values we've found for the standard round.
//
// Sources:
// [1] https://www.tankarchives.ca/2018/09/karabin-wz-35-secret-weapon-of.html
//==============================================================================

class DH_Wz35Weapon extends DHBoltActionWeapon;

// Modified to make ironsights key try to deploy/undeploy the bipod
simulated function ROIronSights()
{
    Deploy();
}

// The Wz. 35 is a magazine fed bolt action. It needs DHBoltActionWeapon for the
// bolt cycle (state WorkingBolt, bMustBeDeployedToBolt, bShouldZoomWhenBolting)
// but not for its reload, which strips loose rounds one at a time out of dummy
// magazines and drives the animation chain PreReload -> SingleReload ->
// PostReload. This rifle carries real 4 round magazines and has none of those
// animations, so the three reload entry points below are routed back to the plain
// magazine reload in DHProjectileWeapon. The PTRD-41, the other anti-tank rifle,
// avoids the problem by extending DHProjectileWeapon directly, at the cost of
// having no bolt cycle at all.
// PerformReload has to be routed here and not just at the entry points, because
// bMustReloadWithBipodDeployed sends the reload to state ReloadingBipod, which is
// declared on DHProjectileWeapon and so does not pick up DHBoltActionWeapon's
// overrides of state Reloading. Its EndState calls PerformReload() virtually, and
// the DHBoltActionWeapon version would load a single round and treat the
// magazines as a pile of loose rounds.
function PerformReload(optional int Count)
{
    super(DHProjectileWeapon).PerformReload(Count);
}

// Routed to the magazine reload: the DHBoltActionWeapon version only sets
// NumRoundsToLoad, which is used solely by the loose round state machine.
simulated function ClientDoReload(optional byte NumRounds)
{
    super(DHProjectileWeapon).ClientDoReload(NumRounds);
}

// Routed to the magazine reload, which also picks state ReloadingBipod when the
// bipod is down. The DHBoltActionWeapon version always uses state Reloading.
function ServerRequestReload()
{
    super(DHProjectileWeapon).ServerRequestReload();
}

// Modified to enforce bMustReloadWithBipodDeployed, which DHBoltActionWeapon's
// AllowReload does not check (it does not call the DHProjectileWeapon version).
// Without this, reloading while undeployed reaches state Reloading, the loose
// round state machine whose animations this rifle does not have.
simulated function bool AllowReload()
{
    return super(DHProjectileWeapon).AllowReload() && super.AllowReload();
}

// Modified to report a full magazine rather than a count of loose rounds, so a
// reload is offered whenever a spare magazine is carried.
simulated function byte GetRoundsToLoad()
{
    if (CurrentMagCount == 0)
    {
        return 0;
    }

    return GetMaxLoadedRounds();
}

simulated state WorkingBolt
{
    // Fire button does nothing while working the bolt.
    simulated function Fire(float F);

    simulated function bool WeaponAllowCrouchChange()
    {
        return false;
    }

    simulated function bool WeaponAllowProneChange()
    {
        return false;
    }
}

simulated state ReloadingBipod
{
    // Fire button does nothing during a reload. Without this the global Fire above
    // would work the bolt part way through the reload, because CanWorkBolt only
    // rejects a busy weapon when it is not already waiting to bolt.
    simulated function Fire(float F);
}

defaultproperties
{
    ItemName="Fucile Controcarro 35(P)"
    FireModeClass(0)=Class'DH_Wz35Fire'
    AttachmentClass=Class'DH_Wz35Attachment'
    PickupClass=Class'DH_Wz35Pickup'

    Mesh=SkeletalMesh'DH_Wz35_anm.wz35_1st'
    bUseHighDetailOverlayIndex=true
    HighDetailOverlayIndex=2

    DisplayFOV=85.0
    IronSightDisplayFOV=55

    bCanHaveInitialNumMagsChanged=false
    bUsesMagazines=true
    MaxNumPrimaryMags=6
    InitialNumPrimaryMags=6

    bCanBipodDeploy=true
    bCanRestDeploy=false
    bCanFireFromHip=false
    bMustReloadWithBipodDeployed=true
    bMustFireWhileSighted=true

    SelectAnim="draw"
    PutDownAnim="putaway"
    IdleToBipodDeploy="bipod_in"
    BipodDeployToIdle="bipod_out"
    BoltIronAnim="iron_bolt"
    BipodIdleAnim="iron_idle"
    BipodMagEmptyReloadAnim="reload_empty"
    BipodMagPartialReloadAnim="reload_empty"
    MagEmptyReloadAnims(0)="reload_empty"

    bShouldZoomWhenBolting=true
    bMustBeDeployedToBolt=true

    StripperClipSize=4
}
