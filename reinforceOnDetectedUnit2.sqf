#include "messyEvac\messyEvacuationConstants.sqf";
#include "messyEvac\scripts\pod\podConstants.sqf";

//Given a list of detected units in a zone, send reinforcements there with spawned artillery units
//UK3CB_CW_SOV_O_LATE_2S1
params ["_unitsDetected", "_spawnMarkerName"];

if (!(count _unitsDetected > 0)) then {
	[format["ReinforceOnDetectedfUnit2.sqf - No units present in detection for %1", _spawnMarkerName]] execVM PT_DEBUG_SQF;
} else {
	//TODO: Check which of our dumpers can reach the target
	//getMarkerPos "dump1" inRangeOfArtillery [[arty5], "rhs_mag_3of56_35"];

	//For each uniti detected, see if we have a dumper available for a drop
	//If the unit is currently involved in a drop, we don't want to interrupt that
	_numDetected = count _unitsDetected;
	_markerPos = getMarkerPos _spawnMarkerName;

	//Get our target
	_tarPos = getPosATL (_unitsDetected select 0);

	[format["ReinforceOnDetectedUnit2 - %1 - Reinforcing on %2 units", _spawnMarkerName, _numDetected]] execVM PT_DEBUG_SQF;

	//TODO: Figure out how we want to create markers to spawn the artillery units to spawn the vehicles at

	//Create an artillery vehicle, give it a crew, and get us its commander
	_calcDir = _markerPos getDir _tarPos;
	//diag_log format["ReinforceOnDetectedUnit2 - Calced Bearing: %1", _calcDir];
	//systemChat format["ReinforceOnDetectedUnit2 - Calced Bearing: %1", _calcDir];

	//TODO: Keep track of how many vehicles we spawn, add a distance onto the marker to move our vehicle spawn so they are not on top of each other?
	for [{private _i = 0}, {_i < (_numDetected / 2)}, {_i = _i + 1}] do {

		[format["ReinforceOnDetectedUnit2 - %1 - Spawn Iteration: %2", _spawnMarkerName, _i]] execVM PT_DEBUG_SQF;

		_markerPos set [1, ((_markerPos select 1) + 15)];//TODO: Take care of extra distance with separate variable otherwise 0, 15, 45, 90, etc. distance instead of 0, 15, 30, 45
		
		[format["ReinforceOnDetectedUnit2 - %1 - Pos for Spawn: %2", _spawnMarkerName, _markerPos]] execVM PT_DEBUG_SQF;

		_spawnVehicleResults = [_markerPos, _calcDir, "UK3CB_CW_SOV_O_LATE_2S1", east] call BIS_fnc_spawnVehicle;
		_createdDumper = _spawnVehicleResults select 0;
		_createdDumperGroup = createGroup east;//Created group for vehicle/group map for allowing units from the same reinforcement wave to be in the same group

		_pooBoys = missionNamespace getVariable "pooBoys";

		if(isNil "_pooBoys") then {

			["ReinforceOnDetectedUnit2 - Pooboys nil creating a home for them"] execVM PT_DEBUG_SQF;
			
			_pooBoys = createHashMap;
		};

		[format["ReinforceOnDetectedUnit2 - %1 - Received pooboys: %2", _spawnMarkerName, _pooBoys]] execVM PT_DEBUG_SQF;
		//Hashmap entry with [#, [created vehicle, created group]]
		//Add our vehicle to the list of vehicles for the replacement trigger - otherwise we're just shooting live explosive artillery instead of poo boys
		_pooBoys insert [[count _pooBoys, [_createdDumper, _createdDumperGroup]]];//pushBack [_createdDumper, _createdDumperGroup];Could add the initiating group to get a stalk script
		missionNamespace setVariable ["pooBoys", _pooBoys];

		[format["ReinforceOnDetectedUnit2 - %1 - Sent pooboys: %2", _spawnMarkerName, _pooBoys]] execVM PT_DEBUG_SQF;
		[format["ReinforceOnDetectedUnit2 - %1 - Sent pooboys keys: %2", _spawnMarkerName, keys _pooBoys]] execVM PT_DEBUG_SQF;

		// diag_log format["ReinforceOnDetectedUnit2 - %1 - %2", _spawnMarkerName, _createdDumper];
		// diag_log format["ReinforceOnDetectedUnit2 - %1 - %2", _spawnMarkerName, _spawnVehicleResults select 1];
		// diag_log format["ReinforceOnDetectedUnit2 - %1 - %2", _spawnMarkerName, _spawnVehicleResults select 2];
		// systemChat format["ReinforceOnDetectedUnit2 - %1 - %2", _spawnMarkerName, _createdDumper];
		// systemChat format["ReinforceOnDetectedUnit2 - %1 - %2", _spawnMarkerName, _spawnVehicleResults select 1];
		// systemChat format["ReinforceOnDetectedUnit2 - %1 - %2", _spawnMarkerName, _spawnVehicleResults select 2];
		_commander = effectiveCommander _createdDumper;

		//_numDumpers = count _dumpers;
		//diag_log format["ReinforceOnDetectedUnit - Have %1 dumpers", _numDumpers];
		//systemChat format["ReinforceOnDetectedUnit - Have %1 dumpers", _numDumpers];

		[
			format[
				"ReinforceOnDetectedUnit2 - %1 - Created vic is in range: %2",
				_spawnMarkerName,
				_tarPos inRangeOfArtillery [[_createdDumper], "rhs_mag_3of56_35"]
			]
		] execVM PT_DEBUG_SQF;
		
		_xRand = random PT_COORDINATE_VARIANCE + (_tarPos select 0);
		_yRand = random PT_COORDINATE_VARIANCE + (_tarPos select 1);
		_adjPos = [_xRand, _yRand, _tarPos select 2];

		diag_log _tarPos;
		diag_log _adjPos;
		//For each dumper, send reinforcements on the location of the first unit noticed
		//{
			//_selectedDumper = _dumpers select _forEachIndex;
			//diag_log _selectedDumper;
			//Get reinforcements equivalent to number enemies present
			_commander commandArtilleryFire [_adjPos, "rhs_mag_3of56_35", _numDetected];
			
			[format["ReinforceOnDetectedUnit2 - %1 - Launching %2 reinforcement bursts", _spawnMarkerName, _numDetected]] execVM PT_DEBUG_SQF;
		//} forEach _dumpers;
	};
};