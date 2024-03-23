#include "..\..\messyEvacuationConstants.sqf";

params ["_pod"];

_podImpactEventHandler = {
	params ["_pod", "_impactedObject", "_unused1", "_unused2", "_reactForce", "_worldPos"];

	[format["ImpactEventHandler - Pod %1 - Called", _pod]] execVM PT_DEBUG_SQF;
	
	//Avoid calling the event again if we bounce around due to latency and velocity
	_pod removeEventHandler [_thisEvent, _thisEventHandler];

	//Stop the pod and play collision noise
	_pod setVelocity [0, 0, 0];
	playSound3D [PT_POD_IMPACT_NOISE, _pod, false, getPosATL _pod, PT_POD_IMPACT_VOL, 1/*Pitch*/];//, 50/*Distance*/];

	
	[format["ImpactEventHandler - Pod %1 - Opening", _pod]] execVM PT_DEBUG_SQF;

	//Open the pod door
	_pod animate ["door_1_rot", 1/*phase, presumption is 1 makes it go through the whole animation*/, PT_POD_OPEN_SPEED];

	//Used to handle a sleep to delay removal of droppod
	[_pod] execVM PT_POD_IMPACT_FOLLOWUP;

	[format["ImpactEventHandler - Pod %1 - Code End", _pod]] execVM PT_DEBUG_SQF;
};

[format["ImpactEventHandler - Pod %1 - Adding impactEventHandler", _pod]] execVM PT_DEBUG_SQF;
//Add the impact event which handles the opening/removing of the pod
_pod addEventHandler ["EpeContactStart", _podImpactEventHandler];