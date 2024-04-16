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

	[format["ReinforceOnDetectedUnit2 - %1 - Reinforcing on %2 units", _spawnMarkerName, _numDetected]] call messyEvac_fnc_debugLog;

	//TODO: Figure out how we want to create markers to spawn the artillery units to spawn the vehicles at

	_calcDir = _markerPos getDir _tarPos;

	//Create an artillery vehicle, give it a crew, and get us its commander
	for [{private _i = 0}, {_i < (_numDetected / 2)}, {_i = _i + 1}] do {

		_createdLauncher = [_spawnMarkerName, _i] call messyEvac_fnc_spawnLauncher;

		[format["ReinforceOnDetectedUnit2 - Created dumper - %1", _createdLauncher]] call messyEvac_fnc_debugLog;
		
		_commander = effectiveCommander _createdLauncher;

		[format[
			"ReinforceOnDetectedUnit2 - %1 - Created vic is in range: %2",
			_spawnMarkerName,
			_tarPos inRangeOfArtillery [[_createdLauncher], "rhs_mag_3of56_35"]
		]] call messyEvac_fnc_debugLog;
		
		// _xRand = random PT_COORDINATE_VARIANCE + (_tarPos select 0);
		// _yRand = random PT_COORDINATE_VARIANCE + (_tarPos select 1);
		_adjPos = [_tarPos] call messyEvac_fnc_addCoordinateVariance;//[_xRand, _yRand, _tarPos select 2];

		//For each dumper, send reinforcements on the location of the first unit noticed
		//{
			//_selectedDumper = _dumpers select _forEachIndex;
			//diag_log _selectedDumper;
			//Get reinforcements equivalent to number enemies present
			_commander commandArtilleryFire [_adjPos, "rhs_mag_3of56_35", _numDetected];
			
			[format["ReinforceOnDetectedUnit2 - %1 - Launching %2 reinforcement bursts", _spawnMarkerName, _numDetected]] call messyEvac_fnc_debugLog;
		//} forEach _dumpers;
	};
};