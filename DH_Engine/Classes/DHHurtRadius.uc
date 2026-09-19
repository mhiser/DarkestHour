//==============================================================================
// Darkest Hour: Europe '44-'45
// Copyright (c) Darklight Games.  All rights reserved.
//==============================================================================

class DHHurtRadius extends Actor
    notplaceable;

var float DamageTimerRate;
var int DamageAmount;
var float DamageRadius;
var class<DamageType> DamageType;
var Controller DelayedDamageInstigatorController;

function PostBeginPlay()
{
    local Projectile ParentProj;

    super.PostBeginPlay();

    ParentProj = Projectile(Owner);

    if (Instigator == none)
    {
        if (ParentProj != none)
        {
            Instigator = ParentProj.Instigator;
        }
        else if (Owner != none)
        {
            Instigator = Owner.Instigator;
        }
    }

    if (ParentProj != none && ParentProj.InstigatorController != none)
    {
        SetDelayedDamageInstigatorController(ParentProj.InstigatorController);
    }
    else if (Instigator != none)
    {
        SetDelayedDamageInstigatorController(Instigator.Controller);
    }
}

function SetDelayedDamageInstigatorController(Controller C)
{
    DelayedDamageInstigatorController = C;

    if (Instigator == none && C != none)
    {
        Instigator = C.Pawn;
    }
}

function Timer()
{
    if (DamageType == none)
    {
        return;
    }

    if (DelayedDamageInstigatorController != none && DelayedDamageInstigatorController.Pawn != none)
    {
        Instigator = DelayedDamageInstigatorController.Pawn;
    }

    HurtRadius(DamageAmount, DamageRadius, DamageType, 0, Location);
}

// Actor.HurtRadius radius math; stamp DelayedDamageInstigatorController like DHAntiVehicleProjectile
function HurtRadius(float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation)
{
    local Actor  Victims;
    local float  DamageScale, Dist;
    local Vector Dir;

    if (bHurtEntry)
    {
        return;
    }

    bHurtEntry = true;

    foreach VisibleCollidingActors(class'Actor', Victims, DamageRadius, HitLocation)
    {
        if (Victims != self && Victims.Role == ROLE_Authority && !Victims.IsA('FluidSurfaceInfo'))
        {
            Dir = Victims.Location - HitLocation;
            Dist = FMax(1.0, VSize(Dir));
            Dir = Dir / Dist;
            DamageScale = 1.0 - FMax(0.0, (Dist - Victims.CollisionRadius) / DamageRadius);

            if (Instigator == none || Instigator.Controller == none)
            {
                Victims.SetDelayedDamageInstigatorController(DelayedDamageInstigatorController);
            }

            Victims.TakeDamage(DamageScale * DamageAmount, Instigator,
                Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * Dir,
                DamageScale * Momentum * Dir, DamageType);

            if (Instigator != none && Vehicle(Victims) != none && Vehicle(Victims).Health > 0)
            {
                Vehicle(Victims).DriverRadiusDamage(DamageAmount, DamageRadius, Instigator.Controller, DamageType, Momentum, HitLocation);
            }
        }
    }

    bHurtEntry = false;
}

function SetDamageTimerRate(int DamageTimerRate)
{
    SetTimer(DamageTimerRate, true);
}

defaultproperties
{
    RemoteRole=ROLE_None
    bHidden=true
    DamageTimerRate=2.0
    DamageRadius=1024.0
}
