eventHandlerVehicle = {
	params ["_vehicle", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile"];

	//TODO: Create a map for vehicles and groups for each vehicle

	//_bdrmVehicle = missionNamespace getVariable "bdrm_bad_launcher";
	_pooBoys = missionNamespace getVariable "pooBoys";/*[
		missionNamespace getVariable "arty1",
		missionNamespace getVariable "arty2",
		missionNamespace getVariable "arty3",
		missionNamespace getVariable "arty4",
		missionNamespace getVariable "arty5"];*/
	
	diag_log format["init sqf - Received pooboys: %1", _pooBoys];

	//TODO: Check if in reads the map, otherwise we need to scan through the first element in each entry
	//pooBoys are formatted like [#key, [vehicle, group]]
	//if (_vehicle in _pooBoys) then {
		
	//forEach _pooBoys;
	({
		_mappedVehicle = _y select 0;
		_poopGroup = _y select 1;

		//If one of our registered pooBoys is firing, then we're firing a pooBoy, ignore otherwise.
		if(_vehicle == _mappedVehicle) then {
			diag_log format["Debug - init - Vehicle matched %1 - Group %2", _vehicle, _poopGroup];
			systemChat format["Debug - init - Vehicle matched %1 - Group %2", _vehicle, _poopGroup];

			diag_log "Debug - Poo boy confirmed, making dookie drop.";
			//Get velocity of projectile then set our pod's position to it.
			_projectileVelocity = velocity _projectile;
			_pod = "Land_ToiletBox_F" createVehicle getPos _projectile;
			deleteVehicle _projectile;
			_pod setVelocity _projectileVelocity;

			//03/16 20:20MST Commented this out to see if it broke the script calls below
			//missionNamespace setVariable ["pod", _pod];//TODO: Check use

			// diag_log "Debug - Calling pooPodImpactEventHandler";
			// systemChat "Debug - Calling pooPodImpactEventHandler.sqf";
			// [_pod, _poopGroup] execVM "pooperTroopers\scripts\pooPodImpactEventHandler.sqf";
			
			diag_log "Debug - Calling pooPodManualDecelDetection";
			systemChat "Debug - Calling pooPodManualDecelDetection.sqf";
			[_pod, _vehicle, _poopGroup] execVM "pooperTroopers\scripts\pooPodManualDecelDetection.sqf";

			// [_pod, _vehicle, _poopGroup] spawn {
			// 	params ["_pod", "_vehicle", "_poopGroup"];
			// 	//We don't want our droppod to end up killing the unitAddons
			// 	//_unit allowDamage false;
			// 	//Wait until we've launched and then presumably hit the ground and slowed
			// 	sleep 2;
			// 	_Vx = 0;
			// 	_Vy = 0;
			// 	_Vz = 0;

			// 	//Declare local var loopCount outside the waitUntil so we can use that to break out of being stuck on a building
			// 	_loopCount = 0;
			// 	waitUntil {
			// 	//When abs of vertical velocity is greater than the vertical postATL then decelerate?
			// 		//Check if the velo is the same as before
			// 		_velo = velocityModelSpace _pod;
			// 		_Vx = _velo select 0;
			// 		_Vy = _velo select 1;
			// 		_Vz = _velo select 2;

			// 		_posATL = getPosATL _pod;
			// 		_Hz = _posATL select 2;
					
			// 		if(_Hz < 20) then {
			// 			//rhsusf\addons\rhsusf_a2port_air\data\sounds\ejection_sound.wss
			// 			playSound3D ["rhsusf\addons\rhsusf_a2port_air\data\sounds\ejection_sound.wss", _pod, false, getPosATL _pod, 5, 1];//Sound previously played after setting the decell velocity
			// 			diag_log ["Debug - ", _Hz, _loopCount, _pod];
			// 			_loopCount = _loopCount + 1;
			// 		};
					
			// 		//LOOP COUNT DOES NOT SEEM TO WORK?
			// 		//If we're stuck at a height above 10 aka on a building, then we can break out of a loop and still 'deploy'
			// 		(_loopCount > 4) || (_Hz < 10);// || (_Vx < 0.1 && _Vx > -0.1) && (_Vy < 0.1 && _Vy > -0.1) && (_Vz < 0.1 && _Vz > -0.1);
			// 		//_Hz < _Vz - Pods tumbled more or hit the ground and tumbled slightly
			// 	};
				
			// 	//Activate deceleration thrusters
			// 	diag_log ["Debug - Decellerating: ", _pod];
			// 	_pod setVelocity [0, 0, -0.05];//[_Vx, _Vy, -0.05]; resulted in a lot of sliding
				
			// 	//Wait until we've touched ground
			// 	waitUntil {
			// 		_Hz = getPosATL _pod select 2;
			// 		diag_log [_Hz, _pod];
			// 		(_loopCount > 4) || (_Hz < 1.5);//TODO: Check if this addition fixes the pods getting stuck on the buildings
			// 	};//Could look at the pod being on the ground for a certain amount of time
				

			// 	//Creating landing crater
			// 	//Create a separate test for this to figure out positioning - Nice to have anyway
			// 	/*diag_log "Debug - crater creation start";
			// 	_crater = createVehicle["Land_ShellCrater_02_small_F", _pod];
			// 	_craterPOS = getPosATL _crater;
			// 	_crater setPosATL [_craterPOS select 0 - 5, _craterPOS select 1, 0];*/

			// 	diag_log "Debug - Before poopGroup set";

			// 	//Grab the poop group paired with our vehicle
			// 	//_poopGroup = _y select 1; //missionNameSpace getVariable "poopGroup";

			// 	//Create a brand new boy to bring into the world in a porta potty
			// 	// if(isNil "_poopGroup") then {
			// 	// 	_poopGroup = createGroup east;
			// 	// 	//TODO: use publicVaribleServer for when it's server collect3DENHistory
			// 	// 	missionNameSpace setVariable["poopGroup", _poopGroup];
			// 	// 	diag_log "Set poopGroup variable";
			// 	// };

			// 	playSound3D ["A3\Sounds_F\sfx\missions\vehicle_collision.wss", _pod, false, getPosATL _pod, 2/*Volume*/, 1/*Pitch*/];//, 50/*Distance*/];

			// 	diag_log format["%1 creating unit for %2", _vehicle, _poopGroup];

			// 	diag_log "Debug - After poopGroup if/else block";

			// 	//Test to make adjustments for crater spawn
			// 	_pod setVelocity [0, 0, 0];
			// 	diag_log "Debug - Spawning Unit Code Start";
			// 	//Rifleman Early USSR - "UK3CB_CW_SOV_O_EARLY_RIF_2"
			// 	//Armored Rifleman Late USSR - "UK3CB_CW_SOV_O_LATE_RIF_2"
			// 	//Armored Special Forces Rifleman Late USSR - "UK3CB_CW_SOV_O_LATE_SF_RIF_2"
			// 	_unit = _poopGroup createUnit ["UK3CB_CW_SOV_O_EARLY_RIF_2", [0,0,0], [], 0, "FORM"];
			// 	_unit allowDamage false;
			// 	_unit setPosATL getPosATL _pod;
			// 	_unit attachTo [_pod, [0,0.8,-1]];
			// 	_unit setDir 180;
			// 	diag_log "Debug - Spawning Unit Code End";

			// 	diag_log ["Debug - Opening: ", _pod];

			// 	//TODO: Maybe have the pod on the ground for a second/enough time to loop before opening?
			// 	//Open the pod door
			// 	_pod animate ["door_1_rot", 1];

			// 	sleep 1;

			// 	deleteVehicle _pod;
			// 	//TODO: Disable damage before hitting the ground or solve the spiraling pod ground slam issue all over.
			// 	_unit allowDamage true;
			// };
			//TODO: Look into removing the vehicles we spawned, or associating them with a location and reusing for any future reinforcement waves
			//Check if our commander is still firing, if not, 
			//_commander = effectiveCommander _vehicle;
			//diag_log format["Debug  - Commander - %1 is %2", _commander, currentCommand _commander];
			//systemChat format["Debug  - Commander %1 is %2", _commander, currentCommand _commander];
			//Once the fire mission is done, clean up after ourselves.
			// deleteVehicleCrew _createdDumper;
			// deleteVehicle _createdDumper;
		};
		
	}) forEach _pooBoys;
};

["ace_firedNonPlayerVehicle", eventHandlerVehicle] call CBA_fnc_addEventHandler;