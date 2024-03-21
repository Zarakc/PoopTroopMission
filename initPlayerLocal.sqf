#include "pooperTroopers\poopTroopConstants.sqf";

//BDRM SETUP START
params ["_player", "_didJIP"];

[_player] execVM "bdrm\scripts\setup\setupLocalPlayer.sqf";
//BDRM SETUP END

if(PT_LOCAL_SCRIPTS == true) then {
	execVM "pooperTroopers\poopTroopAceEvent.sqf";
};
