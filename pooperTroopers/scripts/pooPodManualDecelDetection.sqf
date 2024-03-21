#include "..\poopTroopConstants.sqf";

//Manually detect pod height and engage thrusters prior to impact
params ["_pod", "_poopGroup", "_vehicle"];//Issues without quotes around the variables 

["PodManualDetection - Initial sleep start"] execVM PT_DEBUG_SQF;

sleep PT_INITIAL_SLEEP_ON_LAUNCH;

_stuck = false;
_prevHeight = "";

waitUntil {
	_posATL = getPosATL _pod;
	_Hz = _posATL select 2;
	
	if(_Hz < PT_MANUAL_CHECK_DEBUG_HEIGHT) then {
		[
			format[
				"PodManualDetection - Pod %1 - Decel Height Check %2",
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
//Was in initial waitUntil block
//rhsusf\addons\rhsusf_a2port_air\data\sounds\ejection_sound.wss
playSound3D [PT_POD_DECEL_NOISE, _pod, false, getPosATL _pod, 2/*Volume WAS 5*/, 1];//Sound previously played after setting the decell velocity
		
//Activate deceleration thrusters
[format["PodManualDetection - Pod %1 Decellerating", _pod]] execVM PT_DEBUG_SQF;
_pod setVelocity [0, 0, -0.05];//[_Vx, _Vy, -0.05]; resulted in a lot of sliding

//Set the prevHeight up to use for looping
//Not resetting the loopCount since if it's already 4, we've been stuck and need to break out
_prevHeight = PT_MANUAL_CHECK_DECEL_HEIGHT;
_stuck = false;
_loopIteration = 0;

//Wait until we've touched ground
waitUntil {
	_Hz = getPosATL _pod select 2;

	if (_Hz != _prevHeight) then {
		_prevHeight = _Hz;
		[format["PodManualDetection - Pod %1 - Spawn Height Check %2 - Loop Iteration %3", _pod, _Hz, _loopIteration]] execVM PT_DEBUG_SQF;
	} else {//TODO: Verify this is handled correctly. Seems to trigger immediately based on logs
		_stuck = true;
		[format["PodManualDetection - Pod %1 - Same height %2 - Loop Iteration %3 - Stuck ", _pod, _Hz, _loopIteration]] execVM PT_DEBUG_SQF;
	};

	_loopIteration = _loopIteration + 1;
	sleep .1;

	(_Hz < PT_MANUAL_CHECK_STOP_HEIGHT) || (_stuck isEqualTo true);
};//Could look at the pod being on the ground for a certain amount of time

["PodManualDetection - Calling poopTroopSpawn"] execVM PT_DEBUG_SQF;

[_pod, _poopGroup, _vehicle] execVM "pooperTroopers\scripts\poopTroopSpawn.sqf";