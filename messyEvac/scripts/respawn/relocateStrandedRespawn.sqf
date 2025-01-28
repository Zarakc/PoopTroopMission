#include "..\..\messyEvacuationConstants.sqf";
//From a trigger in Novy Sobor that detects the presence of players

//Grab each person in the zone and then throw them into unoccupied seats in their corresponding respawn vehicle

//Split up the players into their groups
//Go through for each empty seat and spawn a player there (likely exclude the driver seat)
//Overflow will be treated on the next trigger(hopefully)

//Sample Code
private _actionCompatibleCargoIndexes = fullCrew [heli, "cargo", true];
/*
	returns for example (on an empty armed WY-55 Hellcat):
	[
		[objNull, "cargo", 2, [], false, objNull, "$STR_GETIN_POS_PASSENGER"],
		[objNull, "cargo", 3, [], false, objNull, "$STR_GETIN_POS_PASSENGER"],
		[objNull, "cargo", 4, [], false, objNull, "$STR_GETIN_POS_PASSENGER"],
		[objNull, "cargo", 5, [], false, objNull, "$STR_GETIN_POS_PASSENGER"]
	]
	using the element's index is compatible with action cargo commands - see below
*/

// the following commands will put the player in the same seat:
player moveInCargo [heli, 2];
player action ["GetInCargo", heli, 0];

_int = _vehicle emptyPositions "Cargo";