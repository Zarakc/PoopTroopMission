#include "..\..\messyEvacuationConstants.sqf";
#include "heloConstants.sqf";

params ["_helo"];

[format["Helo %1 - Damage Init", _helo]] execVM PT_DEBUG_SQF;
//Could do a mix of needing repair and refueling

//Damage each of the specified helo parts
{
	_part = PT_HELO_DMG_PARTS select _forEachIndex;

	[format["Helo %1 - Damaging %2 to %3", _helo, _part, PT_HELO_DMG_AMOUNT]] execVM PT_DEBUG_SQF;

	_helo setHitPointDamage [PT_HELO_DMG_PARTS select _forEachIndex, PT_HELO_DMG_AMOUNT];
} forEach PT_HELO_DMG_PARTS;

[format["Helo %1 - Removing fuel", _helo]] execVM PT_DEBUG_SQF;
_helo setFuel 0.01;

_fuelTruck = PT_FUEL_VEHICLE_TYPE createVehicle PT_HELO_POS_2;

[format["Fuel Truck %1 - Init", _fuelTruck]] execVM PT_DEBUG_SQF;

_test = getFuelCargo _fuelTruck;//Something about fuelCargo is breaking the debug
[_test] execVM PT_DEBUG_SQF;

[format["Fuel Truck %1 - Fuel reserves %2", _fuelTruck, _test]] execVM PT_DEBUG_SQF;
_fuelTruck setFuelCargo 0;

_test = getFuelCargo _fuelTruck;//debug reports 0, Ace interact reports the full 3k
[format["Fuel Truck %1 - Removed fuel", _fuelTruck]] execVM PT_DEBUG_SQF;
[format["Fuel Truck %1 - Fuel reserves %2", _fuelTruck, _test]] execVM PT_DEBUG_SQF;