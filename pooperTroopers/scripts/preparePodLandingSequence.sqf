#include "..\poopTroopConstants.sqf";

params ["_pod", "_assignedUnitGroup", "_launchVehicle"];

[format["PreparePodLandingSequence - Pod %1 - Decellerating", _pod]] execVM PT_DEBUG_SQF;

_pod setVelocity PT_POD_DECEL_VELOCITY;

[format["PreparePodLandingSequence - Pod %1 - Adding impactEventHandler", _pod]] execVM PT_DEBUG_SQF;
//Add the impact event which handles the opening/removing of the pod
_pod addEventHandler ["EpeContactStart", "pooperTroopers\scripts\podImpactEventHandler.sqf"];

//Spawn the unit
["PreparePodLandingSequence - Calling unit spawn"] execVM PT_DEBUG_SQF;
[_pod, _assignedUnitGroup, _launchVehicle] execVM PT_POD_TROOPER_SPAWN;

_podImpactEventHandler = {
	params ["_pod", "_impactedObject", "_unused1", "_unused2", "_reactForce", "_worldPos"];

	["ImpactEventHandler - Called podImpactEventHandler"] execVM PT_DEBUG_SQF;
	
	//Avoid calling the event again if we bounce around due to latency and velocity
	_pod removeEventHandler [_thisEvent, _thisEventHandler];

	//Stop the pod and play collision noise
	_pod setVelocity [0, 0, 0];
	playSound3D [PT_POD_IMPACT_NOISE, _pod, false, getPosATL _pod, 2/*Volume*/, 1/*Pitch*/];//, 50/*Distance*/];

	
	[format["ImpactEventHandler - Pod %1 - Opening", _pod]] execVM PT_DEBUG_SQF;

	//Open the pod door
	_pod animate ["door_1_rot", 1/*phase, presumption is 1 makes it go through the whole animation*/, PT_POD_OPEN_SPEED];

	sleep PT_POD_PERSIST_DURATION;

	deleteVehicle _pod;

	[format["ImpactEventHandler - Pod %1 - Code End", _pod]] execVM PT_DEBUG_SQF;
};
