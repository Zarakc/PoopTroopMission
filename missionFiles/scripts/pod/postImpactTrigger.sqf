#include "..\..\messyEvacuationConstants.sqf";
#include "podConstants.sqf";

params ["_pod"];

[format["PostImpactTrigger - Pod %1 - Called", _pod]] execVM PT_DEBUG_SQF;

sleep PT_POD_PERSIST_DURATION;

deleteVehicle _pod;

[format["PostImpactTrigger - Pod %1 - Finished", _pod]] execVM PT_DEBUG_SQF;