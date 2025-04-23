#include "heloConstants.sqf";

params["_helo"];

private _numLeft = ["Helo Destroyed"] call messyEvac_fnc_helosLeft;
private _heloEvacTriggers = missionNamespace getVariable ME_HELO_TRIGGERS_VARNAME;

[format["Helo Destroyed - %1. %2 Left", _helo, _numLeft]] call messyEvac_fnc_debugLog;

//If there are/have been multiple helos
	//Check if there are more left
		//If so, more chances text
		//Else, SOL
//If only one
	//SOL

if(count _heloEvacTriggers > 1) then {
	if(_numLeft isEqualTo 0) then {
		["Helo Destroyed - All destroyed text trigger"] call messyEvac_fnc_debugLog;
		systemChat "Your chances of evacuation are all in shambles. You are all left to your fates.";
	} else {
		//We can assume 2 max helos since each sits 18 and mission size is 24
		_firstHeloEvacced = triggerActivated (_heloEvacTriggers select 0);
		_secondHeloEvacced = triggerActivated (_heloEvacTriggers select 1);

		//XOR
		if((_firstHeloEvacced || _secondHeloEvacced) && !(_firstHeloEvacced && _secondHeloEvacced)) then {
			"Helo Destroyed - One of the opportunities of escape have been destroyed. Wave goodbye to those fortunate enough to have escaped on the first helo out." call messyEvac_fnc_debugLog;
			systemChat "One of the opportunities of escape have been destroyed. Wave goodbye to those fortunate enough to have escaped on the first helo out.";
		} else {
			[format["Helo Destroyed - One of the opportunities of escape have been destroyed. Hopefully you don't need to draw straws for the remaining %1.", _numLeft]] call messyEvac_fnc_debugLog;
			systemChat format["One of the opportunities of escape have been destroyed. Hopefully you don't need to draw straws for the remaining %1.", _numLeft];
		};
	};
} else {
	["Helo Destroyed - All(Read: one) destroyed text trigger"] call messyEvac_fnc_debugLog;
	systemChat "Your chance at evacuation lies in shambles. You are all left to your fate.";
};

// if(_numLeft isEqualTo 0) then {
// 	["Helo Destroyed - All destroyed text trigger"] call messyEvac_fnc_debugLog;
// 	systemChat "Chances of evacuation are all in shambles. You are left to your fate.";
// } else {
// 	[format["Helo Destroyed - %1 Left text trigger", _numLeft]] call messyEvac_fnc_debugLog;

	

// 	if(count _heloEvacTriggers > 1) then {
// 		//We want to separate scenarios where there was an evacced helo when the destroy happens 
// 		//	and when there hasn't been one evacced
// 		if((a || b) && !(a && b)) then {
// 			"Helo Destroyed - One of the opportunities of escape have been destroyed. Wave goodbye to those fortunate enough to have escaped on the first helo out." call messyEvac_fnc_debugLog;
// 			systemChat "One of the opportunities of escape have been destroyed. Wave goodbye to those fortunate enough to have escaped on the first helo out.";
// 		} else {
// 			[format["Helo Destroyed - One of the opportunities of escape have been destroyed. Hopefully you don't need to draw straws for the remaining %1.", _numLeft]] call messyEvac_fnc_debugLog;
// 			systemChat format["One of the opportunities of escape have been destroyed. Hopefully you don't need to draw straws for the remaining %1.", _numLeft];
// 		};
// 	} else {
		
// 	};
// 	//TODO: Consider numLeft and normal count?
// 	_helo0Evac = nil;
// 	_helo1Evac = nil;

// 	{
		
// 	} forEach _heloEvacTrigggers;
	//Get helo triggered activation booleans
//};