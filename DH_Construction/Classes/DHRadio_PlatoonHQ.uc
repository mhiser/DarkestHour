//==============================================================================
// Darkest Hour: Europe '44-'45
// Copyright (c) Darklight Games.  All rights reserved.
//==============================================================================

class DHRadio_PlatoonHQ extends DHRadio;

simulated function ERadioUsageError GetRadioUsageError(Pawn User)
{
    local ERadioUsageError Error;
    local DHConstruction_PlatoonHQ HQ;

    Error = super.GetRadioUsageError(User);

    if (Error != ERROR_None)
    {
        return Error;
    }

    // Owner is the HQ attachment; its Owner is the command post.
    if (Owner != none)
    {
        HQ = DHConstruction_PlatoonHQ(Owner.Owner);
    }

    if (HQ == none || HQ.SpawnPoint == none || !HQ.SpawnPoint.bIsEstablished)
    {
        return ERROR_Calibrating;
    }

    return ERROR_None;
}
