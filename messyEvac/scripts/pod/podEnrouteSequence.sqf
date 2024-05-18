#include "..\..\messyEvacuationConstants.sqf";
#include "podConstants.sqf";

//Trigger pod decelleration once a height check is triggered and then call the landing sequence
params ["_pod", "_assignedUnitGroup", "_launchVehicle"];

["PodEnrouteSequence - Initial sleep start"] execVM ME_DEBUG_SQF;

sleep ME_INITIAL_SLEEP_ON_LAUNCH;

_stuck = false;
_prevHeight = "";

waitUntil {
	_posATL = getPosATL _pod;
	_Hz = _posATL select 2;
	
	if(_Hz < ME_MANUAL_CHECK_DEBUG_HEIGHT) then {
		[
			format[
				"PodEnrouteSequence - Pod %1 - Decel Height Check %2",
				_pod,
				_Hz
			]
		] execVM ME_DEBUG_SQF;
		
		if (_Hz isEqualTo _prevHeight) then {
			_stuck = true;
		} else {
			_prevHeight = _Hz;
		};
	};
	
	(_Hz < ME_MANUAL_CHECK_DECEL_HEIGHT) || (_stuck isEqualTo true);
};

["PodEnrouteSequence - Calling landing sequence"] execVM ME_DEBUG_SQF;
[_pod, _assignedUnitGroup, _launchVehicle] execVM ME_POD_LANDING_SEQUENCE;