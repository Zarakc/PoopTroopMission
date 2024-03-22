#include "..\poopTroopConstants.sqf";

params ["_pod", "_assignedUnitGroup", "_launchVehicle"];

[format["PoopTroopSpawn - %1 creating unit for %2", _launchVehicle, _assignedUnitGroup]] execVM PT_DEBUG_SQF;

_unit = _assignedUnitGroup createUnit [PT_UNIT_TYPE, [0,0,0], [], 0, "FORM"];
//_unit allowDamage false;
_unit setPosATL getPosATL _pod;
_unit attachTo [_pod, [0,0.8,-1]];
_unit setDir 180;

["PoopTroopSpawn - Spawning Unit Code End"] execVM PT_DEBUG_SQF;

// //Open pod and allow unit to be injured
// [format["PoopTroopSpawn - Opening %1", _pod]] execVM PT_DEBUG_SQF;

// //TODO: Maybe have the pod on the ground for a second/enough time to loop before opening?
// //Open the pod door
// _pod animate ["door_1_rot", 1];

// sleep 1;

// deleteVehicle _pod;
// //TODO: Disable damage before hitting the ground or solve the spiraling pod ground slam issue all over.
// _unit allowDamage true;

// ["PoopTroopSpawn - Code End"] execVM PT_DEBUG_SQF;