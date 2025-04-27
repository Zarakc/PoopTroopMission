#include "heloConstants.sqf";

params["_trigger"];

private _numLeft = call messyEvac_fnc_helosLeft;

[format["Helo Singleton Leave Trigger - Trigger %1 - Trigger Vehicle - %2 - Helos Left - %3", _trigger, triggerAttachedVehicle _trigger, _numLeft]] call messyEvac_fnc_debugLog;

//[format["Helo Singleton Leave Trigger - Trigger %1 - Attached Helo - %2 - Helos Left - %3", _trigger, _helo, _numLeft]] call messyEvac_fnc_debugLog;

private _heloEvacTriggers = missionNamespace getVariable ME_HELO_TRIGGERS_VARNAME;

[format["Helo Singleton Leave - Helo Alive - %1", alive triggerAttachedVehicle _trigger]] call messyEvac_fnc_debugLog;

//Neither check is reliable on its own
if(alive triggerAttachedVehicle _trigger) then {
	_heloEvacTriggers = _heloEvacTriggers - [_trigger];

	if(!triggerActivated (_heloEvacTriggers select 0)) then {
		[format["Helo Single Evac - One of the helo's has successfully evacced. Hopefully you don't need to draw straws for the remaining %1.", _numLeft]] call messyEvac_fnc_debugLog;
		[format["One of the helo's has successfully evacced. Hopefully you don't need to draw straws for the remaining %1.", _numLeft]] call messyEvac_fnc_systemChat;
	};
} else {
	[triggerAttachedVehicle _trigger, _numLeft, _heloEvacTriggers] call messyEvac_fnc_heloDestroyed;
};
