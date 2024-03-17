#include "..\poopTroopConstants.sqf";

//Manually detect pod height and engage thrusters prior to impact
//params [_pod, _vehicle, _poopGroup];
_pod = _this select 0;
_vehicle = _this select 1;
_poopGroup = _this select 2;

diag_log "Debug - Called pooPodManualDecelDetection";
systemChat "Debug - Called pooPodManualDecelDetection";

//We don't want our droppod to end up killing the unitAddons
//Wait until we've launched and then presumably hit the ground and slowed
sleep 2;
_Vx = 0;
_Vy = 0;
_Vz = 0;

diag_log "Debug - pooPodManualDecelDetection - Initial sleep start";
systemChat "Debug - pooPodManualDecelDetection - Initial sleep start";

sleep 28;

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
		diag_log ["Debug - ", _Hz, _loopCount, _pod];
		_loopCount = _loopCount + 1;
	};
	
	//LOOP COUNT DOES NOT SEEM TO WORK?
	//If we're stuck at a height above 10 aka on a building, then we can break out of a loop and still 'deploy'
	(_loopCount > 4) || (_Hz < PT_MANUAL_CHECK_DECEL_HEIGHT);// || (_Vx < 0.1 && _Vx > -0.1) && (_Vy < 0.1 && _Vy > -0.1) && (_Vz < 0.1 && _Vz > -0.1);
	//_Hz < _Vz - Pods tumbled more or hit the ground and tumbled slightly
};
//Was in initial waitUntil block
//rhsusf\addons\rhsusf_a2port_air\data\sounds\ejection_sound.wss
playSound3D [PT_POD_DECEL_NOISE, _pod, false, getPosATL _pod, 5, 1];//Sound previously played after setting the decell velocity
		
//Activate deceleration thrusters
diag_log ["Debug - Decellerating: ", _pod];
_pod setVelocity [0, 0, -0.05];//[_Vx, _Vy, -0.05]; resulted in a lot of sliding

//Wait until we've touched ground
waitUntil {
	_Hz = getPosATL _pod select 2;
	diag_log [_Hz, _pod];
	(_loopCount > 4) || (_Hz < PT_MANUAL_CHECK_STOP_HEIGHT);//TODO: Check if this addition fixes the pods getting stuck on the buildings
};//Could look at the pod being on the ground for a certain amount of time


//Creating landing crater
//Create a separate test for this to figure out positioning - Nice to have anyway
/*diag_log "Debug - crater creation start";
_crater = createVehicle["Land_ShellCrater_02_small_F", _pod];
_craterPOS = getPosATL _crater;
_crater setPosATL [_craterPOS select 0 - 5, _craterPOS select 1, 0];*/

//diag_log "Debug - Before poopGroup set";

//Grab the poop group paired with our vehicle
//_poopGroup = _y select 1; //missionNameSpace getVariable "poopGroup";

//Create a brand new boy to bring into the world in a porta potty
// if(isNil "_poopGroup") then {
// 	_poopGroup = createGroup east;
// 	//TODO: use publicVaribleServer for when it's server collect3DENHistory
// 	missionNameSpace setVariable["poopGroup", _poopGroup];
// 	diag_log "Set poopGroup variable";
// };

diag_log "Debug - pooPodManualDecelDetection - Calling poopTroopSpawn";
diag_log "Debug - pooPodManualDecelDetection - Calling poopTroopSpawn";

[_pod, _poopGroup, _vehicle] execVM "pooperTroopers\scripts\poopTroopSpawn.sqf";

// playSound3D [PT_POD_IMPACT_NOISE, _pod, false, getPosATL _pod, 5/*Volume*/, 1/*Pitch*/];//, 50/*Distance*/];

// diag_log format["%1 creating unit for %2", _vehicle, _poopGroup];

// diag_log "Debug - After poopGroup if/else block";

// //Test to make adjustments for crater spawn
// _pod setVelocity [0, 0, 0];
// diag_log "Debug - Spawning Unit Code Start";
// //Rifleman Early USSR - "UK3CB_CW_SOV_O_EARLY_RIF_2"
// //Armored Rifleman Late USSR - "UK3CB_CW_SOV_O_LATE_RIF_2"
// //Armored Special Forces Rifleman Late USSR - "UK3CB_CW_SOV_O_LATE_SF_RIF_2"
// _unit = _poopGroup createUnit ["UK3CB_CW_SOV_O_EARLY_RIF_2", [0,0,0], [], 0, "FORM"];
// _unit allowDamage false;
// _unit setPosATL getPosATL _pod;
// _unit attachTo [_pod, [0,0.8,-1]];
// _unit setDir 180;
// diag_log "Debug - Spawning Unit Code End";

// diag_log ["Debug - Opening: ", _pod];

// //TODO: Maybe have the pod on the ground for a second/enough time to loop before opening?
// //Open the pod door
// _pod animate ["door_1_rot", 1];

// sleep 1;

// deleteVehicle _pod;
// //TODO: Disable damage before hitting the ground or solve the spiraling pod ground slam issue all over.
// _unit allowDamage true;