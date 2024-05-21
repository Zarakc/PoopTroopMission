#include "..\..\messyEvacuationConstants.sqf";
#include "podConstants.sqf";

params ["_pod", "_assignedUnitGroup", "_launchVehicle"];

[format["PodTrooperSpawn - %1 creating unit for %2", _launchVehicle, _assignedUnitGroup]] execVM ME_DEBUG_SQF;

_unit = _assignedUnitGroup createUnit [ME_UNIT_TYPE, [0,0,0], [], 0, "FORM"];
//_unit allowDamage false;
_unit setPosATL getPosATL _pod;
_unit attachTo [_pod, [0,0.8,-1]];
_unit setDir 180;

["PodTrooperSpawn - Spawning Unit Code End"] execVM ME_DEBUG_SQF;