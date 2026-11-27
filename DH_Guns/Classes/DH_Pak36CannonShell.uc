//==============================================================================
// Darkest Hour: Europe '44-'45
// Copyright (c) Darklight Games.  All rights reserved.
//==============================================================================
// https://panzerworld.com/armor-penetration-table
// [ ] ballistic coeff, damage & ranging
//==============================================================================

class DH_Pak36CannonShell extends DHGermanCannonShell;

defaultproperties
{
    Speed=44962     // 745m/s
    MaxSpeed=44962
    ShellDiameter=3.7
    BallisticCoefficient=1.2 // verified 37 mm M51 APC scaled by mass (1.52 x 0.685/0.87)

    //Damage
    ImpactDamage=700  //29 gramms TNT filler
    ShellImpactDamage=Class'DH_Engine.DHShellAPGunImpactDamageType'
    HullFireChance=0.45
    EngineFireChance=0.85

    DHPenetrationTable(0)=3.4   // 100m
    DHPenetrationTable(1)=3.1   // 250m
    DHPenetrationTable(2)=2.9   // 500m
    DHPenetrationTable(3)=2.6
    DHPenetrationTable(4)=2.3   // 1000m
    DHPenetrationTable(5)=2.1
    DHPenetrationTable(6)=1.9   // 1500m
    DHPenetrationTable(7)=1.5
    DHPenetrationTable(8)=1.0   // 2000m
    DHPenetrationTable(9)=0.5
    DHPenetrationTable(10)=0.0  // 3000m
}
