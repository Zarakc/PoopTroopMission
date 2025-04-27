
//Array of units who win a prize, the trigger to toggle
params["_prizeWinners", "_trigger"];

private _triggerStatements = triggerStatements _trigger;

private _codeOnActivate = _triggerStatements select 1;
private _codeOnDeactivate = _triggerStatements select 2;

[format["Blow Them Up - Prize Winners: %1", _prizeWinners]] call messyEvac_fnc_debugLog;

//TODO: Doesn't disable the trigger if there are survivors : (
{
	_mine = createMine ["APERSMine", ASLToAGL getPosASL _x, [], 0];

	_mine setDamage 1;//This kills the mine (which blows it up)

	[format["Blow Them Up - Spawned Mine: %1 for %2", _mine, _x]] call messyEvac_fnc_debugLog;
} forEach _prizeWinners;

