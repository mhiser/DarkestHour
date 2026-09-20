//==============================================================================
// Darkest Hour: Europe '44-'45
// Copyright (c) Darklight Games.  All rights reserved.
//==============================================================================

// Unfinished, and not reachable in game: unlike DHPOLTankCrewmanRoles and
// DHSOVTankCrewmanRoles this abstract class has no concrete subclass, so there
// is no role with RolePawns for a Czechoslovak tank crew uniform. Outstanding
// work is art and audio: a crewman pawn class with its uniform, and the vehicle
// and radio lines that DHCzechVoice is still missing.
class DHCSTankCrewmanRoles extends DHAlliedTankCrewmanRoles
    abstract;

defaultproperties
{
    AltName="Tankista"
    PrimaryWeapons(0)=(Item=Class'DH_PPS43Weapon',AssociatedAttachment=Class'ROInventory.ROPPS43AmmoPouch')
    SecondaryWeapons(0)=(Item=Class'DH_Nagant1895Weapon')
    GivenItems(0)="DH_Equipment.DHBinocularsItemSoviet"
    SleeveTexture=Texture'Weapons1st_tex.RussianTankerSleeves'
    DetachedArmClass=Class'SeveredArmSovTanker'
    DetachedLegClass=Class'SeveredLegSovTanker'
    Headgear(0)=Class'DH_SovietTankerHat'
    VoiceType="DH_SovietPlayers.DHCzechVoice"
    AltVoiceType="DH_SovietPlayers.DHCzechVoice"
}
