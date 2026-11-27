//==============================================================================
// Darkest Hour: Europe '44-'45
// Copyright (c) Darklight Games.  All rights reserved.
//==============================================================================

class DHBrokenBottleMeleeFire extends DHMeleeFire;

var Sound TearDownSound;

function Sound GetGroundBashSound(Actor HitActor, Material HitMaterial)
{
    local DHConstruction C;

    C = DHConstruction(HitActor);

    if (C != none)
    {
        if (C.CanTakeTearDownDamageFromPawn(Instigator))
        {
            return TearDownSound;
        }
        else
        {
            return super.GetGroundBashSound(HitActor, HitMaterial);
        }
    }
    else
    {
        return super.GetGroundBashSound(HitActor, HitMaterial);
    }
}

defaultproperties
{
    DamageType=Class'DHTrenchMaceBashDamageType'
    DamageMin=150
    DamageMax=300
    TraceRange=120.0
    FireRate=0.21
    BashBackAnim="bash_pullback_bottle"
    BashHoldAnim="bash_hold_bottle"
    BashAnim="bash_attack_bottle"
    BashFinishAnim="bash_return_bottle"
    TearDownSound=SoundGroup'DH_WeaponSounds.shovel_hit'
    // The bash and stab sounds come from DHMeleeFire (butt_hit, bayo_hit and
    // their ground versions). The bottle sounds BottleSmack and BottleStab were
    // lost in a merge, and the stock melee sounds suit a bottle hit.
}
