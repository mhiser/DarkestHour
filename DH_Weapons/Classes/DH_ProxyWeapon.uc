//==============================================================================
// Darkest Hour: Europe '44-'45
// Copyright (c) Darklight Games.  All rights reserved.
//==============================================================================

class DH_ProxyWeapon extends DHWeapon;

var DHActorProxy                ProxyCursor;

simulated function OnTick(float DeltaTime);
simulated function DHActorProxy CreateProxyCursor();
simulated function OnConfirmPlacement();
simulated function bool ShouldSnapRotation();
simulated function float GetRotationSnapAngle();
simulated function float GetLocalRotationRate();
simulated function ResetCursor();

simulated function bool ShouldSwitchToLastWeaponOnPlacement()
{
    return true;
}

simulated event Tick(float DeltaTime)
{
    super.Tick(DeltaTime);

    if (InstigatorIsLocallyControlled())
    {
        OnTick(DeltaTime);

        // This is not a real inventory item. It is handed out on demand
        // (DHCommandMenu_ConstructionGroup.OnSelect -> DHPawn.ServerGiveWeapon) and
        // destroys itself the moment it is lowered (state LoweringWeapon below),
        // whereas the inventory system expects a weapon to stay in the chain until
        // it is thrown away or runs out of ammo. The cursor is client side only and
        // is created in BringUp, so the cursor and the pawn's Weapon reference can
        // come apart. If the cursor is gone while this is still the current weapon
        // and there is nothing to switch back to, the player is holding an invisible
        // weapon whose only inputs (Fire and ROIronSights) both need the cursor, so
        // put it down and pick something else.
        if (ProxyCursor == none && Instigator.Weapon == self && Instigator.Weapon.OldWeapon == none)
        {
            // We've no weapon to go back to so just put this down, subsequently destroying it
            PutDown();
            Instigator.Controller.SwitchToBestWeapon();
            Instigator.ChangedWeapon();
        }
    }
}

simulated function Destroyed()
{
    if (ProxyCursor != none)
    {
        ProxyCursor.Destroy();
    }

    super.Destroyed();
}

// Modified to create the construction proxy here and also to remove the HasAmmo
// check when setting the OldWeapon since we don't care if the last weapon has
// ammo or not, we still want to switch back it after we're done.
simulated function BringUp(optional Weapon PrevWeapon)
{
    HandleSleeveSwapping();

    if (ROPlayer(Instigator.Controller) != none)
    {
        ROPlayer(Instigator.Controller).FAAWeaponRotationFactor = FreeAimRotationSpeed;
    }

    GotoState('RaisingWeapon');

    if (PrevWeapon != none && !PrevWeapon.bNoVoluntarySwitch)
    {
        OldWeapon = PrevWeapon;
    }
    else
    {
        OldWeapon = none;
    }

    ResetPlayerFOV();

    if (InstigatorIsLocallyControlled())
    {
        if (ProxyCursor != none)
        {
            ProxyCursor.Destroy();
        }

        ProxyCursor = CreateProxyCursor();
    }
}

simulated state LoweringWeapon
{
    simulated function BeginState()
    {
        // NOTE: The !bDeleteMe and GotoState('Idle') are integral to stop
        // stack overflows!
        if (Role == ROLE_Authority && !bDeleteMe)
        {
            GotoState('Idle');
            SelfDestroy();
        }

        super.BeginState();
    }

    simulated function EndState()
    {
        if (!bDeleteMe)
        {
            super.EndState();
        }
    }
}

simulated function bool PutDown()
{
    if (ProxyCursor != none)
    {
        ProxyCursor.Destroy();
    }

    return super.PutDown();
}

simulated function ROIronSights()
{
    local ROPawn P;

    P = ROPawn(Instigator);

    if (InstigatorIsLocallyControlled())
    {
        if (P != none && P.CanSwitchWeapon())
        {
            if (ProxyCursor != none)
            {
                ProxyCursor.Destroy();
            }

            if (Instigator.Weapon.OldWeapon != none)
            {
                Instigator.SwitchToLastWeapon();
                Instigator.ChangedWeapon();
            }
            else
            {
                // We've no weapon to go back to so just put this down, subsequently
                // destroying it.
                PutDown();
                Instigator.Controller.SwitchToBestWeapon();
            }
        }
    }
}

simulated function bool CanConfirmPlacement()
{
    return true;
}

simulated function Fire(float F)
{
    if (InstigatorIsLocallyControlled())
    {
        if (!CanConfirmPlacement())
        {
            return;
        }

        OnConfirmPlacement();

        if (ShouldSwitchToLastWeaponOnPlacement())
        {
            if (ProxyCursor != none)
            {
                ProxyCursor.Destroy();
            }

            if (Instigator.Weapon != none && Instigator.Weapon.OldWeapon != none)
            {
                // The fire button that confirmed the placement is still held. In
                // a standalone game there is no server round trip to swallow it, so
                // the weapon we switch back to takes the same press as soon as it is
                // ready to fire. Putting it back to WS_Hidden makes BringUp treat it
                // as a fresh selection, so it plays its select animation and goes
                // through RaisingWeapon instead of arriving ready to fire.
                // DHPawn.ClientExitATRotation does the same for the AT gun rotate
                // weapon, which is also put away by a fire press.
                if (Level.NetMode == NM_Standalone)
                {
                    Instigator.Weapon.OldWeapon.ClientState = WS_Hidden;
                }

                Instigator.SwitchToLastWeapon();
                Instigator.ChangedWeapon();
            }
            else
            {
                PutDown();
                Instigator.Controller.SwitchToBestWeapon();
            }
        }
    }
}

// Modified to simply reset the location rotation of the proxy.
exec simulated function ROManualReload()
{
    ResetCursor();
}

simulated function bool WeaponLeanLeft()
{
    if (ProxyCursor != none)
    {
        if (ShouldSnapRotation())
        {
            ProxyCursor.LocalRotation.Yaw -= GetRotationSnapAngle();
        }
        else
        {
            ProxyCursor.LocalRotationRate.Yaw = -GetLocalRotationRate();
        }

        return true;
    }

    return false;
}

simulated function bool WeaponLeanRight()
{
    if (ProxyCursor != none)
    {
        if (ShouldSnapRotation())
        {
            ProxyCursor.LocalRotation.Yaw += GetRotationSnapAngle();
        }
        else
        {
            ProxyCursor.LocalRotationRate.Yaw = GetLocalRotationRate();
        }

        return true;
    }

    return false;
}

simulated function WeaponLeanLeftReleased()
{
    if (ProxyCursor != none)
    {
        ProxyCursor.LocalRotationRate.Yaw = 0;
    }
}

simulated function WeaponLeanRightReleased()
{
    if (ProxyCursor != none)
    {
        ProxyCursor.LocalRotationRate.Yaw = 0;
    }
}

defaultproperties
{
    SprintStartAnim="crawl_in"
    SprintLoopAnim="crawl_in"
    SprintEndAnim="crawl_in"
    CrawlForwardAnim="crawl_in"
    CrawlBackwardAnim="crawl_in"
    CrawlStartAnim="crawl_in"
    CrawlEndAnim="crawl_in"
    FireModeClass(0)=Class'DH_EmptyFire'
    FireModeClass(1)=Class'DH_EmptyFire'
    RestAnim="crawl_in"
    AimAnim="crawl_in"
    RunAnim="crawl_in"
    SelectAnim="crawl_in"
    PutDownAnim="crawl_in"
    bCanThrow=false
    Priority=100
    bUsesFreeAim=false
    bCanSway=false
    InventoryGroup=1
    PlayerViewOffset=(X=-6.000000,Y=-6.000000,Z=100000.000000)
    PlayerViewPivot=(Roll=-2730)
    AttachmentClass=Class'DH_EmptyAttachment'
    ItemName=" "
    Mesh=SkeletalMesh'DH_Shovel_1st.Shovel_US'
    bForceSwitch=false
    bNoVoluntarySwitch=true
}

