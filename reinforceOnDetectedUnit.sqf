//Given a list of detected units in a zone, send reinforcements there from available artillery units

_unitsDetected = _this select 0;
_triggerOwner = _this select 1;
_dumpers = [
		missionNamespace getVariable "arty1Cmdr",
		missionNamespace getVariable "arty2Cmdr",
		missionNamespace getVariable "arty3Cmdr",
		missionNamespace getVariable "arty4Cmdr",
		missionNamespace getVariable "arty5Cmdr"
	];

if (isNil "_dumpers") then {
	diag_log "Null dumpers in ReinforceOnDetectedfUnit.sqf";
} else {
	if (!(count _unitsDetected > 0)) then {
		diag_log format["No units present in detection for %1 in ReinforceOnDetectedfUnit.sqf", _triggerOwner];
	} else {
		//TODO: Check which of our dumpers can reach the target
		//getMarkerPos "dump1" inRangeOfArtillery [[arty5], "rhs_mag_3of56_35"];

		//For each uniti detected, see if we have a dumper available for a drop
		//If the unit is currently involved in a drop, we don't want to interrupt that
		_numDetected = count _unitsDetected;
		diag_log format["ReinforceOnDetectedUnit - Reinforcing on %1 units", _numDetected];
		systemChat format["ReinforceOnDetectedUnit - Reinforcing on %1 units", _numDetected];
		//TODO: Figure out how we want to create markers to spawn the artillery units to spawn the vehicles at
		//_createdDumper = createVehicle ["UK3CB_CW_SOV_0_lATE_2S1", getMarkerPos "_createArtATL"];//Pos param can be an array
		//createVehicleCrew [_createdDumper];
		_numDumpers = count _dumpers;
		diag_log format["ReinforceOnDetectedUnit - Have %1 dumpers", _numDumpers];
		systemChat format["ReinforceOnDetectedUnit - Have %1 dumpers", _numDumpers];

		_tarPos = getPosATL (_unitsDetected select 0);
		_xRand = random 20 + (_tarPos select 0);
		_yRand = random 20 + (_tarPos select 1);
		_adjPos = [_xRand, _yRand, _tarPos select 2];
		diag_log _tarPos;
		diag_log _adjPos;
		//For each dumper, send reinforcements on the location of the first unit noticed
		{
			_selectedDumper = _dumpers select _forEachIndex;
			diag_log _selectedDumper;
			//Get reinforcements equivalent to number enemies present
			_selectedDumper commandArtilleryFire [_adjPos, "rhs_mag_3of56_35", _numDetected];
			diag_log "Launching three reinforcement bursts"
		} forEach _dumpers;
	}
};

//call{triggerActivated triggerBravoExplosives;}
//call{this}
//call{[thisList, "commsBravoGroups", [group comsEvacPilot2], [bComsEvac3]] execVM "consolidateSquadsAndSetupTransport.sqf";}