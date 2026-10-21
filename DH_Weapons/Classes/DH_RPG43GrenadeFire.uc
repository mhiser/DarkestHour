//==============================================================================
// Darkest Hour: Europe '44-'45
// Copyright (c) Darklight Games.  All rights reserved.
//==============================================================================

class DH_RPG43GrenadeFire extends DHThrownExplosiveFire;

defaultproperties
{
    ProjectileClass=Class'DH_RPG43GrenadeProjectile'
    AmmoClass=Class'DH_RPG43GrenadeAmmo'
    MinHoldTime=0.5
    bSplashDamage=false
    bRecommendSplashDamage=false
    // Impact fuze, so no fallback timer exists after the throw. ModeTick reads this value.
    // A grenade primed in the hand cooks off 9 seconds after its fuze time runs out.
    AddedFuseTime=9.0
    MinimumThrowSpeed=600.0
    MaximumThrowSpeed=780.0
    SpeedFromHoldingPerSec=600.0
}
