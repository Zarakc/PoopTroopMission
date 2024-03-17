#include "..\poopTroopConstants.sqf";

//Impact event handler for pooPods
//params ["_pooPod", "_poopGroup"];
_pooPod = _this select 0;
_poopGroup = _this select 1;

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

	diag_log "Debug - ImpactEventHandler - Calling poopTroopSpawn";
	diag_log "Debug - ImpactEventHandler - Calling poopTroopSpawn";

	[_pooPod, _poopGroup] execVM "pooperTroopers\scripts\poopTroopSpawn.sqf";

	// _unit = _poopGroup createUnit ["UK3CB_CW_SOV_O_EARLY_RIF_2", [0,0,0], [], 0, "FORM"];
	// _unit allowDamage false;
	// _unit setPosATL getPosATL _pooPod;
	// _unit attachTo [_pooPod, [0,0.8,-1]];
	// _unit setDir 180;

	// diag_log "Debug - ImpactEventHandler - Spawning Unit Code End";

	// //Open pod and allow unit to be injured
	// diag_log ["Debug - Opening: ", _pooPod];

	// //TODO: Maybe have the pod on the ground for a second/enough time to loop before opening?
	// //Open the pod door
	// _pooPod animate ["door_1_rot", 1];

	// sleep 1;

	// deleteVehicle _pooPod;
	// //TODO: Disable damage before hitting the ground or solve the spiraling pod ground slam issue all over.
	// _unit allowDamage true;
};

diag_log "Debug - Adding pooPodImpactEventHandler";
systemChat "Debug - Adding pooPodImpactEventHandler";
_pooPod addEventHandler ["EpeContactStart", _podImpactEventHandler];