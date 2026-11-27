//==============================================================================
// Darkest Hour: Europe '44-'45
// Copyright (c) Darklight Games.  All rights reserved.
//==============================================================================

class DH_DP27LateBullet extends DHBullet;

defaultproperties
{
    Speed=50696.0 // 840 m/s (differs from RO because it stated 2760 fps but with incorrect conversion to UU)
    BallisticCoefficient=0.511 // G1 for 7.62x54R type D heavy ball is about 0.51 to 0.56
    Damage=117.0
    MyDamageType=Class'DH_DP27LateDamType'
}
