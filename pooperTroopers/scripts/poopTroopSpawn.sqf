#include "..\poopTroopConstants.sqf";

params ["_pooPod", "_poopGroup", "_launchVehicle"];

[format["PoopTroopSpawn - %1 creating unit for %2", _launchVehicle, _poopGroup]] execVM PT_DEBUG_SQF;

_unit = _poopGroup createUnit [PT_UNIT_TYPE, [0,0,0], [], 0, "FORM"];
_unit allowDamage false;
_unit setPosATL getPosATL _pooPod;
_unit attachTo [_pooPod, [0,0.8,-1]];
_unit setDir 180;

["PoopTroopSpawn - Spawning Unit Code End"] execVM PT_DEBUG_SQF;

//Open pod and allow unit to be injured
[format["PoopTroopSpawn - Opening %1", _pooPod]] execVM PT_DEBUG_SQF;

//TODO: Maybe have the pod on the ground for a second/enough time to loop before opening?
//Open the pod door
_pooPod animate ["door_1_rot", 1];

sleep 1;

deleteVehicle _pooPod;
//TODO: Disable damage before hitting the ground or solve the spiraling pod ground slam issue all over.
_unit allowDamage true;

["PoopTroopSpawn - Code End"] execVM PT_DEBUG_SQF;