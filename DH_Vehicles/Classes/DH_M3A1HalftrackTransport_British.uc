//==============================================================================
// Darkest Hour: Europe '44-'45
// Copyright (c) Darklight Games.  All rights reserved.
//==============================================================================

// LEGACY class for backwards compatibility as there's no longer any separate vehicle skin with British markings
// The new (from DH v8.0) M3 halftrack skin is generic, with allies markings but not nation or unit specific decals
// Before deleting this class, a maintainer with the map packages must confirm
// that no map still references it: open every package under
// DarkestHourDev/Maps in the SDK and check its actor list, or dump each .rom
// name table and search for "DH_M3A1HalftrackTransport_British". Map packages
// bind actor classes by name at load time, so a map that still references this
// class fails to load once the class is gone, and that cannot be established
// from the source tree alone. Convert any map that still uses it to
// DH_M3A1HalftrackTransport and re-save that map first.

class DH_M3A1HalftrackTransport_British extends DH_M3A1HalftrackTransport;

// Modified to prompt leveller to replace this actor in spawn manager's vehicle pool list (but only for the 1st vehicle to spawn on a map, to avoid log spam)
// Note we can't do this in a BeginPlay event as the vehicle's own VehiclePoolIndex hasn't yet been set when vehicle gets spawned
// So we need to use the controller's VPI & this is the first point in the deployment sequence where we can get a controller reference
function bool TryToDrive(Pawn P)
{
    local DHGameReplicationInfo GRI;
    local int                   VPI;

    if (DHSpawnManager(Owner) != none && P != none && DHPlayer(P.Controller) != none)
    {
        VPI = DHPlayer(P.Controller).VehiclePoolIndex;
        GRI = DHGameReplicationInfo(Level.Game.GameReplicationInfo);

        if (VPI >= 0 && VPI < arraycount(GRI.VehiclePoolActiveCounts) && GRI.VehiclePoolActiveCounts[VPI] < 1)
        {
            Log("Leveller, please replace use of DH_M3A1HalftrackTransport_British with DH_M3A1HalftrackTransport, as this is a temporary legacy actor & in future the map will break", 'MAP WARNING');
        }
    }

    return super.TryToDrive(P);
}
