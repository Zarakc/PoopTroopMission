#include "heloConstants.sqf";

//Where this is being called from for debugging purposes
params["_source"];

//Helos mission variable has to exist here, so no need to check for nil
private _helos = missionNamespace getVariable ME_HELOS;

[format["Helos Left - Called from %1 - Helos %2 ", _source, _helos]] call messyEvac_fnc_debugLog;

private _numHelosLeft = 0;

{
	_helo = _helos select _forEachIndex;

	_alive = alive _helo;

	if(_alive isEqualTo true) then {
		_numHelosLeft = _numHelosLeft + 1;
	};
} forEach _helos;

[format["Helos Left - %1 ", _numHelosLeft]] call messyEvac_fnc_debugLog;

_numHelosLeft;