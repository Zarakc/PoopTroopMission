#include "launcherConstants.sqf";

//missionVarname for reinforcer group to use, Trigger thisList, and trigger itself
params["_launcherGroupKey", "_units", "_trigger"];

//[format["Reinforce On Point - Launcher Group Varname: %1", _launcherGroupKey]] call messyEvac_fnc_debugLog;

//boolean used to see if our launcher(s) are currently busy and call reinforcements if not.
_continue = false;
	
//Grab the group of launchers that we'll be working with
_ourReinforcers = missionNamespace getVariable _launcherGroupKey;
[format["Reinforce On Point - Launcher Group: %1", _ourReinforcers]] call messyEvac_fnc_debugLog;

_reinforcerLeader = _outReinforcers select 0;

//Check if the launcher are busy
_isLauncherBusy = _reinforcerLeader getVariable ME_LAUNCHER_BUSY_VAR;

//Set continue to true if _isLauncherBusy is nil or false
if (isNil "_isLauncherBusy") then {
	
	[format["Reinforce On Point - _isLauncherBusy is nil, setting to true, and continuing"]] call messyEvac_fnc_debugLog;
	_continue = true;

} else {
	if (_isLauncherBusy == false) then {
		[format["Reinforce On Point - _isLauncherBusy is false, continuing"]] call messyEvac_fnc_debugLog;
		_continue = true;
	};
};

//isNil "_isLauncherBusy" || _isLauncherBusy == false, we continue
if (_continue == true) then {

	//["Reinforce On Point - Inside If statement"] call messyEvac_fnc_debugLog;

	//orderLauncherToReinforce.sqf
	[_ourReinforcers, _units, _trigger] execVM ME_LAUNCHER_ORDER_REINFORCEMENTS;
	["Reinforce On Point - Order Reinforcements was called"] call messyEvac_fnc_debugLog;
} else {
	["Reinforce On Point - Else statement - Continue was false"] call messyEvac_fnc_debugLog;
};