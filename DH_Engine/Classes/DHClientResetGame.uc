//===================================================================================================================
// Darkest Hour: Europe '44-'45
// Copyright (c) Darklight Games.  All rights reserved.
//===================================================================================================================

class DHClientResetGame extends Actor;

/*
Matt: this actor is a way of getting all net clients to destroy or reset any actors that need it, as Reset() function is normally only called on server
Gets spawned & replicated to clients if the ResetGame option is used, or a round ends & a new one starts on the same map
Finds all client-authoritative actors, i.e. non-replicated actors existing independently on client (e.g. locally spawned effects), & calls Reset() on them
Then client actor's Reset() function can handle whatever is needed, e.g. for smoke effects it destroys itself so smoke clouds don't persist into new round
Note that Reset also gets called on those actors in single player mode, where it will have the same desired result
Also using it to make sure local player's WeaponUnlockTime is reset for new round

Client round reset contract (issue #106):
- Spawn sites: DarkestHourGame state ResetGame Timer() and state RoundOver Timer().
  Both spawn this actor on a dedicated or listen server just before GotoState('RoundInPlay').
- Server: DarkestHourGame state RoundInPlay BeginState() calls Reset() on every server actor.
  Replicated actors bring clients in line through replication.
- Net clients: this actor calls Reset() on every client-only actor (Role == ROLE_Authority on the client).
  To reset on a client, such an actor overrides Reset().
- Listen server host: the server reset loop already resets the host's local actors.
- Spectators get this reset too. DHPlayer.ClientReset() does not reach them, so keep this actor.
*/

simulated function PostBeginPlay()
{
    local DHPlayer PC;
    local Actor    A;

    if (Role < ROLE_Authority)
    {
        // Find all non-replicated actors existing independently on client & call Reset() on them
        foreach AllActors(Class'Actor', A)
        {
            if (A.Role == ROLE_Authority)
            {
                A.Reset();
            }
        }

        // Make sure local player's WeaponUnlockTime is reset
        PC = DHPlayer(Level.GetLocalPlayerController());

        if (PC != none)
        {
            PC.WeaponUnlockTime = PC.default.WeaponUnlockTime;
        }
    }

    // Destroy a clientside actor as it's done it's job (& this actor has no business existing on a standalone)
    if (Role < ROLE_Authority || Level.NetMode == NM_Standalone)
    {
        Destroy();
    }

    super.PostBeginPlay();
}

defaultproperties
{
    bAlwaysRelevant=true
    bNetTemporary=true // client actor gets torn off as soon as it replicates, as all it needs to do is reach the client to do its stuff
    LifeSpan=5.0       // means server version of this actor will be auto-destroyed after a few seconds, giving it time to replicate to clients
    bSkipActorPropertyReplication=true
    bHidden=true
}
