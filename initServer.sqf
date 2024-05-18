#include "messyEvac\messyEvacuationConstants.sqf";

//BDRM module set up
["========= BDRM - Server Init =========="] execVM PT_DEBUG_SQF;
execVM "bdrm\scripts\setup\setupServer.sqf";

if(PT_LOCAL_SCRIPTS == false) then {
	["========= Server Init =========="] execVM PT_DEBUG_SQF;
	execVM ME_INITIALIZE_MISSION
};