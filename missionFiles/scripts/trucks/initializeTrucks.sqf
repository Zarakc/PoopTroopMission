#include "..\..\messyEvacuationConstants.sqf";
#include "truckConstants.sqf";

//We want to spawn at least one fuel truck, possibly two

//We want to spawn at least one repair truck, possibly two
_spawnLocations = +PT_TRUCK_LOCATIONS;
[format["Truck Spawns %1", _spawnLocations]] execVM PT_DEBUG_SQF;

//WHen we spawn a truck in one of the selected bays, remove that bay from the roster
{
	_truckInfo = PT_TRUCK_SPAWN_DETAILS select _forEachIndex;

	_truckType = _truckInfo select 0;
	_truckWheels = _truckInfo select 1;

	_spawn = selectRandom _spawnLocations;
	[format["Truck Selected Spawn - %1", _spawn]] execVM PT_DEBUG_SQF;

	//Remove used spawn from the list so we don't blow up trucks in tight areas
	_spawnLocations = _spawnLocations - [_spawn];
	[format["Truck Remaining Spawns - %1", _spawnLocations]] execVM PT_DEBUG_SQF;

	_truck = _truckType createVehicle (_spawn select 0);//POS from spawn[]
	_truck setDir (_spawn select 1);//ROT from spawn[]
	
	[format["Truck %1 - Init", _truck]] execVM PT_DEBUG_SQF;

	[_truck, _truckWheels] execVM PT_TRUCK_INIT_DAMAGE;
} forEach PT_TRUCK_SPAWN_DETAILS;
