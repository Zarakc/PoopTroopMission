#include "pooperTroopers\poopTroopConstants.sqf";

//BDRM SETUP START
params ["_player", "_didJIP"];

[_player] execVM "bdrm\scripts\setup\setupLocalPlayer.sqf";
//BDRM SETUP END

if(PT_LOCAL_SCRIPTS == true) then {

	execVM "pooperTroopers\poopTroopAceEvent.sqf"
	// diag_log "Debug - initPlayerLocal Using local script for pooPods";
	// systemChat "Debug - initPlayerLocal Using local script for pooPods";

	// eventHandler = {
	// 	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile"];

	// 	_array = [_unit, _weapon, _muzzle, _mode, _ammo, _magazine, _projectile];
	// 	diag_log _array;
	// 	diag_log currentThrowable _unit;

	// 	_vel = velocity _projectile;
	// 	deleteVehicle _projectile;
	// 	_unit setVelocity _vel;
	// };
	// //The replace you with bullet caller
	// //["ace_firedPlayer", eventHandler] call CBA_fnc_addEventHandler;


	// eventHandlerVehicleOld = {
	// 	params ["_vehicle", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile"];

	// 	_vel = velocity _projectile;
	// 	_vehicle setVelocity _vel;

	// 	_array = [_vehicle, _weapon, _muzzle, _mode, _ammo, _magazine, _projectile];

	// 	diag_log _array;
	// 	diag_log magazinesDetail _vehicle;

	// 	missionNamespace setVariable ["last_fired", _projectile];
	// 	[_projectile] spawn {
	// 		params ["_projectile"];

	// 		sleep 2;
	// 		waitUntil {(getPosATL _projectile) select 2 <= 1};
	// 		missionNamespace setVariable ["impact_pos", getPosATL _projectile];

	// 		_pos = missionNameSpace getVariable "impact_pos";
	// 		_group = createGroup west;
	// 		sleep 10;
	// 		"B_Soldier_A_F" createUnit [_pos, _group];
	// 	};	
	// };

	// eventHandlerVehicle = {
	// 	params ["_vehicle", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile"];

	// 	//TODO: Create a map for vehicles and groups for each vehicle

	// 	//_bdrmVehicle = missionNamespace getVariable "bdrm_bad_launcher";
	// 	_pooBoys = missionNamespace getVariable "pooBoys";/*[
	// 		missionNamespace getVariable "arty1",
	// 		missionNamespace getVariable "arty2",
	// 		missionNamespace getVariable "arty3",
	// 		missionNamespace getVariable "arty4",
	// 		missionNamespace getVariable "arty5"];*/
		
	// 	diag_log format["init sqf - Received pooboys: %1", _pooBoys];

	// 	//TODO: Check if in reads the map, otherwise we need to scan through the first element in each entry
	// 	//pooBoys are formatted like [#key, [vehicle, group]]
	// 	//if (_vehicle in _pooBoys) then {
			
	// 	//forEach _pooBoys;
	// 	({
	// 		_mappedVehicle = _y select 0;
	// 		_poopGroup = _y select 1;

	// 		//If one of our registered pooBoys is firing, then we're firing a pooBoy, ignore otherwise.
	// 		if(_vehicle == _mappedVehicle) then {
	// 			diag_log format["Debug - init - Vehicle matched %1 - Group %2", _vehicle, _poopGroup];
	// 			systemChat format["Debug - init - Vehicle matched %1 - Group %2", _vehicle, _poopGroup];

	// 			diag_log "Poo boy confirmed, making dookie drop.";
	// 			//Get velocity of projectile then set our pod's position to it.
	// 			_projectileVelocity = velocity _projectile;
	// 			_pod = "Land_ToiletBox_F" createVehicle getPos _projectile;
	// 			deleteVehicle _projectile;
	// 			_pod setVelocity _projectileVelocity;
				
	// 			//missionNamespace setVariable ["pod", _pod];//TODO: Check use
	// 			// diag_log "Debug - Before poopGroup set";

	// 			if(PT_IMPACT_EVENT_FOR_PODS == true) then {
	// 				//Use the impact detection event for the unit spawning/opening
	// 				diag_log "Debug - Calling pooPodImpactEventHandler";
	// 				systemChat "Debug - Calling pooPodImpactEventHandler.sqf";
	// 				[_pod, _poopGroup, _vehicle] execVM "pooperTroopers\scripts\pooPodImpactEventHandler.sqf";

	// 			} else {
	// 				//Use the height waitUntils
	// 				diag_log "Debug - Calling pooPodManualDecelDetection";
	// 				systemChat "Debug - Calling pooPodManualDecelDetection.sqf";
	// 				[_pod, _poopGroup, _vehicle] execVM "pooperTroopers\scripts\pooPodManualDecelDetection.sqf";
	// 			};

	// 			//TODO: Look into removing the vehicles we spawned, or associating them with a location and reusing for any future reinforcement waves
	// 			//Check if our commander is still firing, if not, 
	// 			//_commander = effectiveCommander _vehicle;
	// 			//diag_log format["Debug  - Commander - %1 is %2", _commander, currentCommand _commander];
	// 			//systemChat format["Debug  - Commander %1 is %2", _commander, currentCommand _commander];
	// 			//Once the fire mission is done, clean up after ourselves.
	// 			// deleteVehicleCrew _createdDumper;
	// 			// deleteVehicle _createdDumper;
	// 		};
			
	// 	}) forEach _pooBoys;
	// };

	// ["ace_firedNonPlayerVehicle", eventHandlerVehicle] call CBA_fnc_addEventHandler;
};
