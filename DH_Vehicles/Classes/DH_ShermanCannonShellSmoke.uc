//==============================================================================
// Darkest Hour: Europe '44-'45
// Copyright (c) Darklight Games.  All rights reserved.
//==============================================================================

class DH_ShermanCannonShellSmoke extends DHCannonShellSmokeWP;

defaultproperties
{
    Speed=37358.0 // 2030 fps or 619 m/s
    MaxSpeed=37358.0
    ShellDiameter=7.5
    BallisticCoefficient=2.8 // BC/SD 1.60, inside the verified band

    //Penetration
    DHPenetrationTable(0)=0.2
    DHPenetrationTable(1)=0.2
    DHPenetrationTable(2)=0.2
    DHPenetrationTable(3)=0.2
    DHPenetrationTable(4)=0.1
}
