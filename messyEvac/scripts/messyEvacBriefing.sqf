if (!hasInterface) exitWith {};
waitUntil {!isNull player};
// ====================================================================================
// NOTES: CREDITS
// The code below creates the Friendly Assets sub-section of notes.

_mis = player createDiaryRecord ["diary", ["Credits","
Brief message about the credits.
<br/>
<br/>
* Oronar - Let's us not have to write a lot of extra respawning code!
* Zarakc - Wrote too many scripts and ended up with a repo to avoid the fall into insanity.
"]];

// ====================================================================================
// NOTES: Respawning
// The code below creates the mission sub-section of notes.

_mis = player createDiaryRecord ["diary", ["Respawn Rules","
Respawning
<br/>
<br/>
Each set of squads (Southern/Eastern) has their own respawn vehicle.

If you've been dead for 5+ minutes and there are still helo's up, feel free to respawn.
Otherwise, section/team leads/survivors can call respawns after taking exterior bases, and whenever else reasonable.

This is meant more as a warmup mission, so it's preferrable to not have people out for too long if things are still ongoing.
"]];

// ====================================================================================
// NOTES: MISSION
// The code below creates the mission sub-section of notes.

_mis = player createDiaryRecord ["diary", ["Mission","
Breakdown
<br/>
<br/>
Get to the airstrip
Find our means of exfiltraction
Get it running
Hope someone can fly whatever we find
Survive the flight
"]];

// ====================================================================================

// NOTES: SITUATION
// The code below creates the situation sub-section of notes.

_sit = player createDiaryRecord ["diary", ["Situation","
FUBAR
<br/>
<br/>
The mission to discover what the Russians have been working on has gone FUBAR.
We're pulling the plug and getting ourselves out of here. Thankfully, we commandeered some vehicles that brought us this far.

The airfield should have a helo to extract us, minor snag is intel says there's been a backlog of repairs and refueling. 

We might need to do some field repair/refueling and find the matching vehicles

Whatever the case, we're going to need to buckle up 'cause it's going to be a messy evacuation.
<br/>
"]];