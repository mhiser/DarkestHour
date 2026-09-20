//==============================================================================
// Darkest Hour: Europe '44-'45
// Copyright (c) Darklight Games.  All rights reserved.
//==============================================================================
// Deprecated shim: an empty subclass of DH_Weapons.DH_Kz8cmGrW42Weapon
// that only exists so the old DH_Mortars.DH_Kz8cmGrW42Weapon name still
// resolves.
//
// Before deleting it, a maintainer must check two things that cannot be
// settled from the source tree:
//   1. That no map package references it. Open every package under
//      DarkestHourDev/Maps in the SDK and check for a weapon pickup or
//      inventory spawner whose weapon class is DH_Mortars.DH_Kz8cmGrW42Weapon,
//      or dump each .rom name table and search for "DH_Mortars". A mapper can
//      set DHPlaceableWeaponPickup.WeaponType to any weapon class in the
//      editor, so any weapon class can end up referenced by a map.
//   2. That DH_Mortars is no longer needed as a package. It is listed in both
//      +EditPackages and +ServerPackages in DarkestHourDev/System/Default.ini
//      and it holds only this class and DH_M2MortarWeapon, so deleting both
//      empties the package and Default.ini has to be updated in the same
//      change or the build breaks.
//==============================================================================

class DH_Kz8cmGrW42Weapon extends DH_Weapons.DH_Kz8cmGrW42Weapon;
