#include "pooperTroopers\poopTroopConstants.sqf";

//BDRM module set up
diag_log "========= BDRM - Server Init ==========";
execVM "bdrm\scripts\setup\setupServer.sqf";

if(PT_LOCAL_SCRIPTS == false) then {
	diag_log "========= Pooper Troopers - Server Init ==========";
	systemChat "========= Pooper Troopers - Server Init ==========";
	execVM "pooperTroopers\poopTroopAceEvent.sqf"
};