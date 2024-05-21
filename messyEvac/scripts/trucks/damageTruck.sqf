#include "..\..\messyEvacuationConstants.sqf";
#include "truckConstants.sqf";

params ["_truck", "_truckWheels"];

[format["Truck %1 - Damage Init", _truck]] execVM ME_DEBUG_SQF;

//See how many wheels we can get away with damaging before it needs to be repaired to move
// _wheels = [
// 			"hitlfwheel", "hitlf2wheel", "hitlmwheel",
// 			"hitrfwheel", "hitrf2wheel", "hitrmwheel"
// 		];

//TODO: Adjust random per vehicle - repair might have 3/4 wheels down - which is ass.

_numWheels = count _truckWheels;

[format["Truck %1 - Half Wheels %2", _truck, (_numWheels / 2)]] execVM ME_DEBUG_SQF;

_numWheelsToDamage = ceil (random (_numWheels / 2));

[format["Truck %1 - Wheels %2", _truck, _truckWheels]] execVM ME_DEBUG_SQF;
[format["Truck %1 - Damaging %2 wheels", _truck, _numWheelsToDamage]] execVM ME_DEBUG_SQF;

while { _numWheelsToDamage > 0} do {
	_wheel = selectRandom _truckWheels;

	//Remove our selected wheel so we don't pick the same
	//If there's an easy way to do it, errors looped about the below
	//_wheels = _wheels - [_wheel];

	[format["Truck %1 - Damaging %2 to %3", _truck, _wheel, 1]] execVM ME_DEBUG_SQF;

	_truck setHitPointDamage [_wheel, 1];

	//This line is important if we want to play the game and not "Make log get big and also not load into the game"
	_numWheelsToDamage = _numWheelsToDamage -1;
};

//Possibly defuel only if a non-fuel truck
if(typeOf _truck != ME_FUEL_VEHICLE_TYPE) then {

} else {
	_test = getFuelCargo _truck;//Something about fuelCargo is breaking the debug
	[_test] execVM ME_DEBUG_SQF;

	[format["Fuel Truck %1 - Fuel reserves %2", _truck, _test]] execVM ME_DEBUG_SQF;
	_truck setFuelCargo 0;

	_test = getFuelCargo _truck;//debug reports 0, Ace interact reports the full 3k
	[format["Fuel Truck %1 - Removed fuel", _truck]] execVM ME_DEBUG_SQF;
	[format["Fuel Truck %1 - Fuel reserves %2", _truck, _test]] execVM ME_DEBUG_SQF;
};
