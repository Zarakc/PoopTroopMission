#include "..\poopTroopConstants.sqf";

//Impact event handler for pooPods
_pooPod = _this select 0;
_poopGroup = _this select 1;
_launchVehicle = _this select 2;

_podImpactEventHandler = {
	params ["_pooPod", "_impactedObject", "_unused1", "_unused2", "_reactForce", "_worldPos"];

	diag_log "Debug - Called podImpactEventHandler";
	systemChat "Debug - Called podImpactEventHandler";

	//Stop the pod and play collision noise
	_pooPod setVelocity [0, 0, 0];
	playSound3D [PT_POD_IMPACT_NOISE, _pooPod, false, getPosATL _pooPod, 2/*Volume*/, 1/*Pitch*/];//, 50/*Distance*/];

	//Unit Creation
	diag_log "Debug - ImpactEventHandler - Spawning Unit Code Start";

	//Rifleman Early USSR - "UK3CB_CW_SOV_O_EARLY_RIF_2"
	//Armored Rifleman Late USSR - "UK3CB_CW_SOV_O_LATE_RIF_2"
	//Armored Special Forces Rifleman Late USSR - "UK3CB_CW_SOV_O_LATE_SF_RIF_2"

	diag_log "ImpactEventHandler - Calling poopTroopSpawn";
	systemChat "ImpactEventHandler - Calling poopTroopSpawn";

	//Avoid calling the event again if we bounce around due to latency and velocity
	_pooPod removeEventHandler [_thisEvent, _thisEventHandler];
	
	_podData = _pooPod getVariable "data";
	diag_log format["ImpactEventHandler - podData: %1", _podData];
	diag_log format["ImpactEventHandler - group: %1", _podData select 0];
	diag_log format["ImpactEventHandler - vehicle: %1", _podData select 1];

	[_pooPod, _podData select 0, _podData select 1] execVM "pooperTroopers\scripts\poopTroopSpawn.sqf";
};

//Setting the variable to the object since they can't carry over into the eventHandler
_pooPod setVariable ["data", [_poopGroup, _launchVehicle]];

diag_log "ImpactEventHandler - Adding pooPodImpactEventHandler";
systemChat "ImpactEventHandler - Adding pooPodImpactEventHandler";
_pooPod addEventHandler ["EpeContactStart", _podImpactEventHandler];