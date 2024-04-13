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

[format["Helos Left - %1 ", _numHelosLeft]] call messyEvac_fnc_debugLog;

_numHelosLeft;