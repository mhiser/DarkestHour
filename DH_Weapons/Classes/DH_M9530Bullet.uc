//==============================================================================
// Darkest Hour: Europe '44-'45
// Copyright (c) Darklight Games.  All rights reserved.
//==============================================================================

class DH_M9530Bullet extends DHBullet;  //8x56R

defaultproperties
{
    Speed=37418.24              // 700m/s (http://www.hungariae.com/Mann31.htm)
    BallisticCoefficient=0.515 // 8x56R M.30 S spitzer, same class as the 7.92 mm sS (Kar98) bullet
    Damage=114.0
    MyDamageType=Class'DH_M9530DamType'
}