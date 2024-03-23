#include "..\..\messyEvacuationConstants.sqf";
#include "podConstants.sqf";

//Trigger pod decelleration once a height check is triggered and then call the landing sequence
params ["_pod", "_assignedUnitGroup", "_launchVehicle"];

["PodEnrouteSequence - Initial sleep start"] execVM PT_DEBUG_SQF;

sleep PT_INITIAL_SLEEP_ON_LAUNCH;

_stuck = false;
_prevHeight = "";

waitUntil {
	_posATL = getPosATL _pod;
	_Hz = _posATL select 2;
	
	if(_Hz < PT_MANUAL_CHECK_DEBUG_HEIGHT) then {
		[
			format[
				"PodEnrouteSequence - Pod %1 - Decel Height Check %2",
				_pod,
				_Hz
			]
		] execVM PT_DEBUG_SQF;
		
		if (_Hz isEqualTo _prevHeight) then {
			_stuck = true;
		} else {
			_prevHeight = _Hz;
		};
	};
	
	(_Hz < PT_MANUAL_CHECK_DECEL_HEIGHT) || (_stuck isEqualTo true);
};

["PodEnrouteSequence - Calling landing sequence"] execVM PT_DEBUG_SQF;
[_pod, _assignedUnitGroup, _launchVehicle] execVM PT_POD_LANDING_SEQUENCE;