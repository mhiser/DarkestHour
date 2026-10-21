//==============================================================================
// Darkest Hour: Europe '44-'45
// Copyright (c) Darklight Games.  All rights reserved.
//==============================================================================
// Deprecated, but still shipping. A placeable pickup can only exist in a map
// package, and maps bind actor classes by name at load time, so a map that
// still places one fails to load once the class is gone. An import-table scan
// of all 202 shipped maps (issue #43) found 119 placed in these 10 maps:
//
//   Armored_Celles_Clash        15
//   Endsieg_Advance              6
//   Haunted_Darkest_Wonderland   4
//   Hedgerow_Hell_Advance        2
//   Hurtgenwald_Advance         20
//   Hurtgenwald_Push            16
//   Jurques_Dusk_Advance         1
//   Kriegstadt_Push_USA         49
//   Pegasus_Bridge_Advance       2
//   Rhine_River_Advance          4
//
// To retire it, replace each one in those maps with a DHPlaceableWeaponPickup
// whose WeaponType is DH_PanzerFaustWeapon and re-save the map. Then delete
// this class and its abstract base DH_DeprecatedPickups, which has no other
// subclass.
//==============================================================================

class DH_PlaceablePanzerFaustPickup extends DH_DeprecatedPickups;

