//==============================================================================
// Darkest Hour: Europe '44-'45
// Copyright (c) Darklight Games.  All rights reserved.
//==============================================================================

class DH_M34GrenadeFire extends DHThrownExplosiveFire;

defaultproperties
{
    ProjectileClass=Class'DH_M34GrenadeProjectile'
    AmmoClass=Class'DH_M34GrenadeAmmo'
    bSplashDamage=false
    bRecommendSplashDamage=false
    // Impact fuze, so no fallback timer exists after the throw. ModeTick reads this value.
    // A grenade primed in the hand cooks off 9 seconds after its fuze time runs out.
    AddedFuseTime=9.0
    MinHoldTime=0.29
}
