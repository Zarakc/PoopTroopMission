#include "heloConstants.sqf";

params["_helo", "_numLeft", "_heloEvacTriggers"];

[format["Helo Destroyed - %1. %2 Left", _helo, _numLeft]] call messyEvac_fnc_debugLog;

if(count _heloEvacTriggers > 1) then {
	if(_numLeft isEqualTo 0) then {
		["Helo Destroyed - All destroyed text trigger"] call messyEvac_fnc_debugLog;
		["Your chances of evacuation are all in shambles."] call messyEvac_fnc_systemChat;
	} else {
		//We can assume 2 max helos since each sits 18 and mission size is 24
		_firstHeloTrigger = _heloEvacTriggers select 0;
		_secondHeloTrigger = _heloEvacTriggers select 1;
		_firstHeloEvacced = triggerActivated _firstHeloTrigger && alive (triggerAttachedVehicle _firstHeloTrigger);
		_secondHeloEvacced = triggerActivated _secondHeloTrigger && alive (triggerAttachedVehicle _secondHeloTrigger);

		if((_firstHeloEvacced || _secondHeloEvacced)) then {
			"Helo Destroyed - One Evacced Prior Scenario." call messyEvac_fnc_debugLog;
			["Wave goodbye to those fortunate enough to have escaped on the first helo out, yours is gone."] call messyEvac_fnc_systemChat;
		} else {
			[format["Helo Destroyed - One of the opportunities of escape have been destroyed. Hopefully you don't need to draw straws for the remaining %1.", _numLeft]] call messyEvac_fnc_debugLog;
			[format["One of the opportunities of escape have been destroyed. Hopefully you don't need to draw straws for the remaining %1.", _numLeft]] call messyEvac_fnc_systemChat;
		};
	};
} else {
	["Helo Destroyed - All(Read: one) destroyed text trigger"] call messyEvac_fnc_debugLog;
	["Your chance at evacuation lies in shambles. You are all left to your fate."] call messyEvac_fnc_systemChat;
};
