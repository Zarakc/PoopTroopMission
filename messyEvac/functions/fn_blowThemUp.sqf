
//Array of units who win a prize, the trigger to toggle
params["_prizeWinners", "_trigger"];

private _triggerStatements = triggerStatements _trigger;

private _codeOnActivate = _triggerStatements select 1;
private _codeOnDeactivate = _triggerStatements select 2;

[_trigger, "Initial Trigger", "Init"] call messyEvac_fnc_outputTriggerStatements;

//Disable the reinforce trigger we're working with
[_trigger] call messyEvac_fnc_disableReinforceTrigger;
[_trigger, "Disable mine1 Trigger", "Deactivation"] call messyEvac_fnc_outputTriggerStatements;

[format["Blow Them Up - Prize Winners: %1", _prizeWinners]] call messyEvac_fnc_debugLog;

{
	//_x
	_mine = createMine ["APERSMine", ASLToAGL getPosASL _x, [], 0];
	_mine setDamage 1;
	[format["Blow Them Up - Spawned Mine: %1 for %2", _mine, _x]] call messyEvac_fnc_debugLog;
} forEach _prizeWinners;

_trigger setTriggerInterval 5;

//TODO: Refactor to parameterize interval and activation condition (orderLaunchersToReinforce uses this same logic)
//'Renable' the trigger by setting the condition back to its original value
_trigger setTriggerStatements ["this", _codeOnActivate, _codeOnDeactivate];
[_trigger, "Enable mine1 Trigger", "Reactivation"] call messyEvac_fnc_outputTriggerStatements;
