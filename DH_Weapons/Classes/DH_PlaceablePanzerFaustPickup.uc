//==============================================================================
// Darkest Hour: Europe '44-'45
// Copyright (c) Darklight Games.  All rights reserved.
//==============================================================================
// Deprecated, but still shipping: this is a placeable pickup, so it can only
// exist in a map package, and nothing in the source tree can tell us whether a
// map still places one. Before deleting it, a maintainer with the map packages
// must open every package under DarkestHourDev/Maps in the SDK and confirm
// none holds a DH_PlaceablePanzerFaustPickup actor, or dump each .rom name
// table and search for "DH_PlaceablePanzerFaustPickup". Map packages bind
// actor classes by name at load time, so a map that still places one fails to
// load once the class is gone. Replace any that are found with a
// DHPlaceableWeaponPickup whose WeaponType is DH_PanzerFaustWeapon, re-save
// the map, and only then delete this class and its abstract base
// DH_DeprecatedPickups, which has no other subclass.
//==============================================================================

class DH_PlaceablePanzerFaustPickup extends DH_DeprecatedPickups;

