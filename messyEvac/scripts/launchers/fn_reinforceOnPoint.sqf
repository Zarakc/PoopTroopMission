#include "launcherConstants.sqf";

//Trigger thisList and trigger itself
params["_units", "_trigger"];

["Reinforce On Point - Called"] call messyEvac_fnc_debugLog;

//boolean used to see if our launcher(s) are currently busy and call reinforcements if not.
_continue = false;

//Check if the launcher are BIS_fnc_supplydrop
_launcher = missionNamespace getVariable "arty1";

_isLauncherBusy = _launcher getVariable ME_LAUNCHER_BUSY_VAR;

//Set continue to true if _isLauncherBusy is nil or false
if (isNil "_isLauncherBusy") then {
	[format["Reinforce On Point - _isLauncherBusy is nil, setting to true, and continuing"]] call messyEvac_fnc_debugLog;
	_continue = true;

	//TODO: Verify their removal here

	// //Add launcher to the group the first time this triggers //TODO: Just do on start up of mission
	// //Create a group for the launcher to use for its spawned units
	// _launcherSpecificGroup = createGroup ME_LAUNCHER_SIDE;

	// //Add the launcher to our marked group so artillery shells turn into reinforcements
	// [_launcher, _launcherSpecificGroup] call messyEvac_fnc_addLauncherToGroup;

} else {
	if (_isLauncherBusy == false) then {
		[format["Reinforce On Point - _isLauncherBusy is false, continuing"]] call messyEvac_fnc_debugLog;
		_continue = true;
	};
};

//isNil "_isLauncherBusy" || _isLauncherBusy == false, we continue
if (_continue == true) then {

	["Reinforce On Point - Inside If statement"] call messyEvac_fnc_debugLog;

	[_launcher, _units, _trigger] execVM ME_LAUNCHER_ORDER_REINFORCEMENTS;
	["Reinforce On Point - Order Reinforcements was called"] call messyEvac_fnc_debugLog;
} else {
	["Reinforce On Point - Else statement - Continue was false"] call messyEvac_fnc_debugLog;
};