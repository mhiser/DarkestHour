//==============================================================================
// Darkest Hour: Europe '44-'45
// Copyright (c) Darklight Games.  All rights reserved.
//==============================================================================

class DH_LTypeGrenadeFire extends DHThrownExplosiveFire;

defaultproperties
{
    ProjectileClass=Class'DH_LTypeGrenadeProjectile'
    AmmoClass=Class'DH_LTypeGrenadeAmmo'
    MinHoldTime=0.4
    bSplashDamage=false
    bRecommendSplashDamage=false
    // Impact fuze, so no fallback timer exists after the throw. ModeTick reads this value.
    // A grenade primed in the hand cooks off 9 seconds after its fuze time runs out.
    AddedFuseTime=9.0
    MinimumThrowSpeed=500
    MaximumThrowSpeed=750
    SpeedFromHoldingPerSec=400.0
}
