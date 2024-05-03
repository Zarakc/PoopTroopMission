params["_group", "_hideBool"];

[format["Hide Reinforcements: %1 for %2", _hideBool, _group]] call messyEvac_fnc_debugLog;

{
	_x hideObject _hideBool;

	//Disable the AI on init so dinguses don't hop out when hidden
	if(_hideBool isEqualTo true) then {
		_x disableAI "ALL";
		[format["AI Disabled: %1 for %2", _hideBool, _group]] call messyEvac_fnc_debugLog;
	} else {
		_x enableAI "ALL";
		[format["AI Enabled: %1 for %2", _hideBool, _group]] call messyEvac_fnc_debugLog;
	};
} forEach units _group;