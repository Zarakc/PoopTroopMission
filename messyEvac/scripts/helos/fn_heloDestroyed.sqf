#include "heloConstants.sqf";

params["_helo"];

[format["Helo Destroyed - %1", _helo]] call messyEvac_fnc_debugLog;

_numLeft = [] call messyEvac_fnc_helosLeft;

[format["Helo Destroyed - %1 Left", _numLeft]] call messyEvac_fnc_debugLog;

if(_numLeft isEqualTo 0) then {
	["Helo Destroyed - All destroyed text trigger"] call messyEvac_fnc_debugLog;
	systemChat "Chances of evacuation are all in shambles. You are left to your fate.";
} else {
	[format["Helo Destroyed - %1 Left text trigger", _numLeft]] call messyEvac_fnc_debugLog;
	systemChat format["One of the opportunities of escape have been destroyed. Hopefully you don't need to draw straws for the remaining %1.", _numHelosLeft];
};