#include "..\poopTroopConstants.sqf";

params ["_pod", "_assignedUnitGroup", "_launchVehicle"];

[format["PreparePodLandingSequence - Pod %1 - Decellerating", _pod]] execVM PT_DEBUG_SQF;

//TODO: See how much this is needed or if impact handler could be sufficient
_pod setVelocity PT_POD_DECEL_VELOCITY;

//Add the impact handling trigger to the pod
[_pod] execVM PT_POD_IMPACT_HANDLER;

//Spawn the unit in the pod
["PreparePodLandingSequence - Calling unit spawn"] execVM PT_DEBUG_SQF;
[_pod, _assignedUnitGroup, _launchVehicle] execVM PT_POD_TROOPER_SPAWN;
