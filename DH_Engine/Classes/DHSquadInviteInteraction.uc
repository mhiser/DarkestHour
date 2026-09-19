//==============================================================================
// Darkest Hour: Europe '44-'45
// Copyright (c) Darklight Games.  All rights reserved.
//==============================================================================

class DHSquadInviteInteraction extends DHPromptInteraction;

var string SenderName;
var string SquadName;
var int TeamIndex;
var int SquadIndex;

function string GetPromptText()
{
    local string Text;

    Text = Repl(default.PromptText, "{0}", Class'GameInfo'.static.MakeColorCode(Class'DHColor'.default.SquadColor) $ SenderName $ Class'GameInfo'.static.MakeColorCode(Class'UColor'.default.White));
    Text = Repl(Text, "{1}", Class'GameInfo'.static.MakeColorCode(Class'DHColor'.default.SquadColor) $ SquadName $ Class'GameInfo'.static.MakeColorCode(Class'UColor'.default.White));

    return Text;
}

function OnOptionSelected(int Index)
{
    local DHPlayer PC;

    PC = DHPlayer(ViewportOwner.Actor);

    if (PC != none)
    {
        switch (Index)
        {
            case 0: // Accept
                PC.ServerSquadJoin(TeamIndex, SquadIndex, true);
                break;
            case 1: // Decline
                break;
            case 2: // Ignore All
                PC.bIgnoreSquadInvitations = true;
                break;
        }
    }

    Master.RemoveInteraction(self);
}

defaultproperties
{
    PromptText="{0} has invited you to join {1} squad."
    Options(0)=(Key=IK_F1,Text="Accept",Command="AcceptSquadInvite")
    Options(1)=(Key=IK_F2,Text="Decline",Command="DeclineSquadInvite")
    Options(2)=(Key=IK_F3,Text="Ignore All",Command="IgnoreSquadInvites")
}
