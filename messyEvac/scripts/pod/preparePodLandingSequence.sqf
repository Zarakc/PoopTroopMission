#include "..\..\messyEvacuationConstants.sqf";
#include "podConstants.sqf";

//Called from podEnrouteSequence
params ["_pod", "_assignedUnitGroup", "_launchVehicle"];

//[format["PreparePodLandingSequence - Pod %1 - Decellerating", _pod]] execVM ME_DEBUG_SQF;

//TODO: See how much this is needed or if impact handler could be sufficient
_pod setVelocity ME_POD_DECEL_VELOCITY;
playSound3D [ME_POD_DECEL_NOISE, _pod, false, getPosATL _pod, ME_POD_DECEL_VOL, 1/*Pitch*/];//, 50/*Distance*/];

//Spawn the unit in the pod
//["PreparePodLandingSequence - Calling unit spawn"] execVM ME_DEBUG_SQF;
[_pod, _assignedUnitGroup, _launchVehicle] execVM ME_POD_TROOPER_SPAWN;
