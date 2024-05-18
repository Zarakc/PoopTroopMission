#include "..\..\messyEvacuationConstants.sqf";
#include "podConstants.sqf";

params ["_pod"];

[format["PostImpactTrigger - Pod %1 - Called", _pod]] execVM ME_DEBUG_SQF;

sleep ME_POD_PERSIST_DURATION;

deleteVehicle _pod;

[format["PostImpactTrigger - Pod %1 - Finished", _pod]] execVM ME_DEBUG_SQF;