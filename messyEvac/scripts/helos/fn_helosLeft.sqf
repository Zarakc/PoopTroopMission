#include "heloConstants.sqf";

//Helos mission variable has to exist here, so no need to check for nil
private _helos = missionNamespace getVariable ME_HELOS;

private _numHelosLeft = 0;

{
	_helo = _helos select _forEachIndex;

	_alive = alive _helo;//TODO: Check if we need to check damage in addition to alive

	if(_alive isEqualTo true) then {
		_numHelosLeft = _numHelosLeft + 1;
	};
} forEach _helos;

_numHelosLeft;