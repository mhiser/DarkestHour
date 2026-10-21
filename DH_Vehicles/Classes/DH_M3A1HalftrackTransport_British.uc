//==============================================================================
// Darkest Hour: Europe '44-'45
// Copyright (c) Darklight Games.  All rights reserved.
//==============================================================================

// LEGACY class for backwards compatibility as there's no longer any separate vehicle skin with British markings
// The new (from DH v8.0) M3 halftrack skin is generic, with allies markings but not nation or unit specific decals
// Do not delete this class yet. An import-table scan of the 202 map packages
// under DarkestHourDev/Maps (issue #42) found 10 maps that reference it. Each
// reference is in a DHSpawnManager vehicle pool, not a placed actor. The maps
// are the Cagny Recon Clash, Eindhoven Clash, Hill112, La Champagne,
// St Lambert (two maps), Vieux, Bridgehead, Carpiquet Airfield and Schijndel
// maps. Map packages bind classes by name at load time, so these maps fail to
// load if this class is gone. Change each vehicle pool entry to
// DH_M3A1HalftrackTransport and re-save the map before you delete this class.
// The scan does not cover community maps outside the repo.

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
