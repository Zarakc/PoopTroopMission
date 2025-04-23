#include "heloConstants.sqf";

params["_trigger"];

[format["Helo Singleton Leave Trigger - %1 - Helos Left - %2", _helo, ["Helo Singleton Leave Trigger"] call messyEvac_fnc_helosLeft]] call messyEvac_fnc_debugLog;

private _numLeft = ["Helo Destroyed"] call messyEvac_fnc_helosLeft;
private _heloEvacTriggers = missionNamespace getVariable ME_HELO_TRIGGERS_VARNAME;

if(count _heloEvacTriggers > 1) then {
	_heloEvacTriggers = _heloEvacTriggers - [_trigger];

	if(!triggerActivated (_heloEvacTriggers select 0)) then {
		[format["Helo Single Evac - One of the helo's has successfully evacced. Hopefully you don't need to draw straws for the remaining %1.", (_numLeft -1)]] call messyEvac_fnc_debugLog;
		systemChat format["One of the helo's has successfully evacced. Hopefully you don't need to draw straws for the remaining %1.", (_numLeft -1)];
	};
};
