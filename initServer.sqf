#include "messyEvac\messyEvacuationConstants.sqf";

//BDRM module set up
["========= BDRM - Server Init =========="] execVM ME_DEBUG_SQF;
execVM "bdrm\scripts\setup\setupServer.sqf";

if(ME_LOCAL_SCRIPTS == false) then {
	["========= Server Init =========="] execVM ME_DEBUG_SQF;
	execVM ME_INITIALIZE_MISSION
};