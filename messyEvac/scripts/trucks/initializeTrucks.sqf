#include "..\..\messyEvacuationConstants.sqf";
#include "..\helos\heloConstants.sqf";
#include "truckConstants.sqf";

params ["_playerCount"];

[format["Trucks - Passed player count - %1", _playerCount]] call messyEvac_fnc_debugLog;

//Calling the respawn vehicle damage set up
[] execVM ME_RESPAWN_VEHICLE_SETUP;

//Creating a copy of the array so we can perform local-only changes
_spawnLocations = +ME_TRUCK_LOCATIONS;
[format["Truck Spawns %1", _spawnLocations]] call messyEvac_fnc_debugLog;

//Based on player count, spawn an extra truck if we're spawning multiple helo's
_desiredHeloCount = ceil (_playerCount / ME_HELO_SEATS);

//Loop through for each helo we're expecting
for [{private _i = 0}, {_i < _desiredHeloCount}, {_i = _i + 1}] do {

	//Spawn one of each truck type (repair, fuel)
	{
		_truckInfo = ME_TRUCK_SPAWN_DETAILS select _forEachIndex;

		_truckType = _truckInfo select 0;
		_truckWheels = _truckInfo select 1;

		_spawn = selectRandom _spawnLocations;
		[format["Truck Spawns - Selected: %1", _spawn]] call messyEvac_fnc_debugLog;

		//Remove used spawn from the list so we don't spawn in the same spots
		_spawnLocations = _spawnLocations - [_spawn];
		[format["Truck Spawns - Remaining: %1", _spawnLocations]] call messyEvac_fnc_debugLog;

		_truck = _truckType createVehicle (_spawn select 0);//POS from spawn[]
		_truck setDir (_spawn select 1);//ROT from spawn[]
		
		//Comment for sanity check since the repair kits weren't present in hosted server for testing
		[format["Truck Spawns - Type of Truck: %1. Repair Type: %2", typeOf _truck, ME_REPAIR_VEHICLE_TYPE]] call messyEvac_fnc_debugLog;

		//If we're making a repair vehicle, spawn two repair kit in the back of item
		if(typeOf _truck == ME_REPAIR_VEHICLE_TYPE) then {
			[format["Truck Spawns - Adding Toolkits to: %1", _truck]] call messyEvac_fnc_debugLog;
			_truck addItemCargoGlobal ["ToolKit",2];//Was addItemCargo - didn't work on server but this block was reached
		};
		
		[format["Truck %1 - Init", _truck]] call messyEvac_fnc_debugLog;

		[_truck, _truckWheels] execVM ME_TRUCK_INIT_DAMAGE;
	} forEach ME_TRUCK_SPAWN_DETAILS;

};