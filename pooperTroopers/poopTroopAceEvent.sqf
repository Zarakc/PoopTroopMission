#include "poopTroopConstants.sqf";

eventHandlerVehicle = {
	params ["_vehicle", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile"];

	//_bdrmVehicle = missionNamespace getVariable "bdrm_bad_launcher";
	_pooBoys = missionNamespace getVariable "pooBoys";/*[
		missionNamespace getVariable "arty1",
		missionNamespace getVariable "arty2",
		missionNamespace getVariable "arty3",
		missionNamespace getVariable "arty4",
		missionNamespace getVariable "arty5"];*/
	
	diag_log format["init sqf - Received pooboys: %1", _pooBoys];

	//TODO: Check if in reads the map, otherwise we need to scan through the first element in each entry
	//pooBoys are formatted like [#key, [vehicle, group]]
	//if (_vehicle in _pooBoys) then {
		
	//forEach _pooBoys;
	({
		_mappedVehicle = _y select 0;
		_poopGroup = _y select 1;

		//If one of our registered pooBoys is firing, then we're firing a pooBoy, ignore otherwise.
		if(_vehicle == _mappedVehicle) then {
			diag_log format["Debug - init - Vehicle matched %1 - Group %2", _vehicle, _poopGroup];
			systemChat format["Debug - init - Vehicle matched %1 - Group %2", _vehicle, _poopGroup];

			diag_log "Debug - Poo boy confirmed, making dookie drop.";
			//Get velocity of projectile then set our pod's position to it.
			_projectileVelocity = velocity _projectile;
			_pod = "Land_ToiletBox_F" createVehicle getPos _projectile;
			deleteVehicle _projectile;
			_pod setVelocity _projectileVelocity;

			//03/16 20:20MST Commented this out to see if it broke the script calls below
			//missionNamespace setVariable ["pod", _pod];//TODO: Check use

			if(PT_IMPACT_EVENT_FOR_PODS == true) then {
				//Use the impact detection event for the unit spawning/opening
				diag_log "Debug - Calling pooPodImpactEventHandler";
				systemChat "Debug - Calling pooPodImpactEventHandler.sqf";
				[_pod, _poopGroup, _vehicle] execVM "pooperTroopers\scripts\pooPodImpactEventHandler.sqf";

			} else {
				//Use the height waitUntils
				diag_log "Debug - Calling pooPodManualDecelDetection";
				systemChat "Debug - Calling pooPodManualDecelDetection.sqf";
				[_pod, _poopGroup, _vehicle] execVM "pooperTroopers\scripts\pooPodManualDecelDetection.sqf";
			};
		};
		
	}) forEach _pooBoys;
};

["ace_firedNonPlayerVehicle", eventHandlerVehicle] call CBA_fnc_addEventHandler;