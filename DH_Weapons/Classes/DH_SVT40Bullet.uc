//==============================================================================
// Darkest Hour: Europe '44-'45
// Copyright (c) Darklight Games.  All rights reserved.
//==============================================================================

class DH_SVT40Bullet extends DHBullet;

defaultproperties
{
    Speed=50696.0 // 2756 fps  // TODO: was 2519 fps in RO, why the change?
    BallisticCoefficient=0.511 // G1 for 7.62x54R type D heavy ball is about 0.51 to 0.56
    Damage=117.0
    MyDamageType=Class'DH_SVT40DamType'
}
