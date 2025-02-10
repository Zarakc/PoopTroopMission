#include "..\..\messyEvacuationConstants.sqf";
#include "truckConstants.sqf";

//Type of vehicle and wheel damage scenarios
params ["_truck", "_wheelDmgScenarios"];

[format["Truck %1 - Damage Init", _truck]] call messyEvac_fnc_debugLog;

private _wheelsToDamage = selectRandom _wheelDmgScenarios;
[format["Truck %1 - Wheel Scenario %2", _truck, _wheelsToDamage]] call messyEvac_fnc_debugLog;

{
	[format["Truck %1 - Damaging %2 to %3", _truck, _x, 0.9]] call messyEvac_fnc_debugLog;

	//Only partially damaging the wheels since the extra spare is removed now
	_truck setHitPointDamage [_x, 0.9];
} forEach _wheelsToDamage;

//Possibly defuel the repair truck
if(typeOf _truck != ME_FUEL_VEHICLE_TYPE) then {
	//0.005 is enough to get the repair to the further helo it seems
	private _fuelAmountScenarios = [0.007, 0.005, 0.005, 0.002, 0];
	
	private _repairTruckFuel = fuel _truck;

	private _fuelSetAmount = selectRandom _fuelAmountScenarios;

	[format["Fuel Truck %1 - Fuel reserves %2", _truck, _repairTruckFuel]] call messyEvac_fnc_debugLog;
	_truck setFuel _fuelSetAmount;

	_repairTruckFuel = fuel _truck;
	[format["Fuel Truck %1 - Updated Fuel reserves %2", _truck, _repairTruckFuel]] call messyEvac_fnc_debugLog;
};
