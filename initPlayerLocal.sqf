#include "messyEvac\messyEvacuationConstants.sqf";

//BDRM SETUP START
params ["_player", "_didJIP"];

[_player] execVM "bdrm\scripts\setup\setupLocalPlayer.sqf";
//BDRM SETUP END

execVM "messyEvac\scripts\messyEvacBriefing.sqf";

if(ME_LOCAL_SCRIPTS == true) then {
	execVM ME_INITIALIZE_MISSION;
};