#include "heloConstants.sqf";

params["_helo"];

[format["Helo %1 - Destroyed", _helo]] call messyEvac_fnc_debugLog;

//Helos mission variable has to exist here, so no need to check for nil
_helos = missionNamespace getVariable PT_HELOS;

_allDed = true;
_numHelosLeft = 0;

{
	_helo = _helos select _forEachIndex;

	_alive = alive _helo;

	if(_alive isEqualTo true) then {
		_allDed = false;
		_numHelosLeft = _numHelosLeft + 1;
	};
} forEach _helos;

if(_allDed) then {
	systemChat "Chances of evacuation are all in shambles. You are left to your fate.";
} else {
	systemChat format["One of the opportunities of escape have been destroyed. Hopefully you don't need to draw straws for seating on the remaining %1.", _numHelosLeft];
};