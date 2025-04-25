#include "..\..\messyEvacuationConstants.sqf";
#include "heloConstants.sqf";

//Called from messyEvacuationMissionInitialization
params ["_playerCount"];

[format["Helo Init - Player count %1", _playerCount]] call messyEvac_fnc_debugLog;

private _heloSeatCount = [ME_TRANSIT_HELO_TYPE, true] call BIS_fnc_crewCount;
[format["Helo's seat %1", _heloSeatCount]] call messyEvac_fnc_debugLog;

//See how many helo's we'd need at the start;
private _desiredHeloCount = ceil (_playerCount / _heloSeatCount);

[format["Num required helo's %1", _desiredHeloCount]] call messyEvac_fnc_debugLog;

//Creating a copy of the array so we can perform local-only changes
private _spawnLocations = +ME_HELO_SPAWN_POINTS;

for [{private _i = 0}, {_i < _desiredHeloCount}, {_i = _i + 1}] do {

	//Grab one of the spawns
	_spawnPoint = selectRandom _spawnLocations;

	//Remove used spawn from the list so we don't spawn in the same spots
	_spawnLocations = _spawnLocations - [_spawnPoint];

	_pos = _spawnPoint select 0;
	_helo = ME_TRANSIT_HELO_TYPE createVehicle _pos;

	_rot = _spawnPoint select 1;
	_helo setDir _rot;

	//Add the helo to a list of helos for the game
	_helos = missionNamespace getVariable ME_HELOS;

	if(isNil "_helos") then {

		[format["Helo Init - %1 - Spawned Helos nil, creating entry", _helo]] call messyEvac_fnc_debugLog;
	
		_helos = [];
	};

	_helos append [_helo];

	//Update the mission variable with the helo
	missionNamespace setVariable [ME_HELOS, _helos, true];//Did not include bool param
	[format["Helo Init - Helos to save to variable - %1", missionNamespace getVariable ME_HELOS]] call messyEvac_fnc_debugLog;

	[_helo] execVM ME_HELO_INIT_DAMAGE;

	[format["Helo Init - %1 - Calling Trigger", _helo]] call messyEvac_fnc_debugLog;
	[_helo, _i] call messyEvac_fnc_heloTriggerSetUp;
};

//Once each helo and its trigger is created, make our single trigger to know if all helos left the A/O or are destroyed
[] call messyEvac_fnc_heloCombineTriggers;