#include "..\poopTroopConstants.sqf";

//Manually detect pod height and engage thrusters prior to impact
params ["_pod", "_poopGroup", "_vehicle"];//Issues without quotes around the variables 

["PodManualDetection - Initial sleep start"] execVM PT_DEBUG_SQF;

sleep PT_INITIAL_SLEEP_ON_LAUNCH;

//We don't want our droppod to end up killing the unitAddons
//Wait until we've launched and then presumably hit the ground and slowed
_Vx = 0;
_Vy = 0;
_Vz = 0;
//TODO: Velocity can go as it is all currently unused

//Declare local var loopCount outside the waitUntil so we can use that to break out of being stuck on a building
_loopCount = 0;

waitUntil {
//When abs of vertical velocity is greater than the vertical postATL then decelerate?
	//Check if the velo is the same as before
	_velo = velocityModelSpace _pod;
	_Vx = _velo select 0;
	_Vy = _velo select 1;
	_Vz = _velo select 2;

	_posATL = getPosATL _pod;
	_Hz = _posATL select 2;
	
	if(_Hz < PT_MANUAL_CHECK_DEBUG_HEIGHT) then {
		[
			format[
				"PodManualDetection - Decel Height Check %1 - Loop %2 - Pod %3",
				_Hz,
				_loopCount,
				_pod
			]
		] execVM PT_DEBUG_SQF;
		
		_loopCount = _loopCount + 1;
	};//TODO: Change from loop to matching values like the post decel check does
	
	//LOOP COUNT DOES NOT SEEM TO WORK?
	//If we're stuck at a height above 10 aka on a building, then we can break out of a loop and still 'deploy'
	(_loopCount > 4) || (_Hz < PT_MANUAL_CHECK_DECEL_HEIGHT);// || (_Vx < 0.1 && _Vx > -0.1) && (_Vy < 0.1 && _Vy > -0.1) && (_Vz < 0.1 && _Vz > -0.1);
	//_Hz < _Vz - Pods tumbled more or hit the ground and tumbled slightly
};
//Was in initial waitUntil block
//rhsusf\addons\rhsusf_a2port_air\data\sounds\ejection_sound.wss
playSound3D [PT_POD_DECEL_NOISE, _pod, false, getPosATL _pod, 5, 1];//Sound previously played after setting the decell velocity
		
//Activate deceleration thrusters
[format["PodManualDetection - Decellerating %1", _pod]] execVM PT_DEBUG_SQF;//TODO Validate if this works
_pod setVelocity [0, 0, -0.05];//[_Vx, _Vy, -0.05]; resulted in a lot of sliding

//Set the prevHeight up to use for looping
//Not resetting the loopCount since if it's already 4, we've been stuck and need to break out
_prevHeight = PT_MANUAL_CHECK_DECEL_HEIGHT;
_stuck = false;

//Wait until we've touched ground
waitUntil {
	_Hz = getPosATL _pod select 2;

	if (_Hz != _prevHeight) then {
		_prevHeight = _Hz;
		[format["PodManualDetection -  Loop %1 - Height Check %2 For Spawn %3", _loopCount, _Hz, _pod]] execVM PT_DEBUG_SQF;
	} else {
		_stuck = true;
		[format["PodManualDetection - Same height %1 pod %2 stuck ", _Hz, _pod]] execVM PT_DEBUG_SQF;
	};

	(_Hz < PT_MANUAL_CHECK_STOP_HEIGHT) || (_stuck isEqualTo true);
};//Could look at the pod being on the ground for a certain amount of time

["PodManualDetection - Calling poopTroopSpawn"] execVM PT_DEBUG_SQF;

[_pod, _poopGroup, _vehicle] execVM "pooperTroopers\scripts\poopTroopSpawn.sqf";