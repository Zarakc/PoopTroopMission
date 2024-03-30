#include "..\..\messyEvacuationConstants.sqf";
#include "..\helos\heloConstants.sqf";
#include "truckConstants.sqf";

params ["_playerCount"];

[format["Trucks - Passed player count - %1", _playerCount]] execVM PT_DEBUG_SQF;

//Creating a copy of the array so we can perform local-only changes
_spawnLocations = +PT_TRUCK_LOCATIONS;
[format["Truck Spawns %1", _spawnLocations]] execVM PT_DEBUG_SQF;

//Based on player count, spawn an extra truck if we're spawning multiple helo's
_desiredHeloCount = ceil (_playerCount / PT_HELO_SEATS);

//Loop through for each helo we're expecting
for [{private _i = 0}, {_i < _desiredHeloCount}, {_i = _i + 1}] do {

	//Spawn one of each truck type (repair, fuel)
	{
		_truckInfo = PT_TRUCK_SPAWN_DETAILS select _forEachIndex;

		_truckType = _truckInfo select 0;
		_truckWheels = _truckInfo select 1;

		_spawn = selectRandom _spawnLocations;
		[format["Truck Selected Spawn - %1", _spawn]] execVM PT_DEBUG_SQF;

		//Remove used spawn from the list so we don't spawn in the same spots
		_spawnLocations = _spawnLocations - [_spawn];
		[format["Truck Remaining Spawns - %1", _spawnLocations]] execVM PT_DEBUG_SQF;

		_truck = _truckType createVehicle (_spawn select 0);//POS from spawn[]
		_truck setDir (_spawn select 1);//ROT from spawn[]
		
		[format["Truck %1 - Init", _truck]] execVM PT_DEBUG_SQF;

		[_truck, _truckWheels] execVM PT_TRUCK_INIT_DAMAGE;
	} forEach PT_TRUCK_SPAWN_DETAILS;

};