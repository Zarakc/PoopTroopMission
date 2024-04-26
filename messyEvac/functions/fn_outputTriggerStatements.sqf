//Our trigger object and a string value to add as the debug location header
params["_trigger", "_debugHeader", "_accessDetails"];

_triggerStatements = triggerStatements _trigger;

_condition = _triggerStatements select 0;
_codeOnActivate = _triggerStatements select 1;
_codeOnDeactivate = _triggerStatements select 2;

[format["%1 - Trigger Condition %2: %3", _debugHeader, _accessDetails, _condition]] call messyEvac_fnc_debugLog;
[format["%1 - Trigger Activate %2: %3", _debugHeader, _accessDetails, _codeOnActivate]] call messyEvac_fnc_debugLog;
[format["%1 - Trigger Deactive %2: %3", _debugHeader, _accessDetails, _codeOnDeactivate]] call messyEvac_fnc_debugLog;
