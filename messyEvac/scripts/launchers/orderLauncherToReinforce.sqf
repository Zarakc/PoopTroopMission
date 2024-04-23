#include "launcherConstants.sqf";

//Called from fn_reinforceOnPoint.sqf
//Commander of our reinforcement launcher, units in the trigger, and the trigger used to call reinforcements
params["_launcher", "_units", "_trigger"];

//TODO: Set up logging to more easily handle this and not complicate the messages in the code file itself
_ORDER_REINFORCE_DEBUG_HEADER = "Order Launcher To Reinforce";

[format["Order Launcher To Reinforce - Trigger - %1", _trigger]] call messyEvac_fnc_debugLog;

//Grab the groupings
_launcherGroupings = missionNamespace getVariable ME_LAUNCHER_GROUPINGS_VARNAME;
[format["Order Launcher To Reinforce - Launcher Groupings - %1", _launcherGroupings]] call messyEvac_fnc_debugLog;

//Hashmap for [reinforceGroupName,  _launchers[]]
_launchersForPosition = _launcherGroupings get ME_LAUNCHER_HELO_REINFORCERS;//TODO: Parameterize the group to grab
[format["Order Launcher To Reinforce - Launchers for Position - %1", _launchersForPosition]] call messyEvac_fnc_debugLog;//Error Undefined variable in expression: _launchers

_leadLauncher = _launchersForPosition select 0;

[format["Order Launcher To Reinforce - Lead Launcher - %1", _leadLauncher]] call messyEvac_fnc_debugLog;//Was using 'select' instead of 'get'

//Mark the lead launcher of the grouping as busy and 'disable' our trigger for now
_leadLauncher setVariable [ME_LAUNCHER_BUSY_VAR, true];

//Disable the reinforce trigger we're working with
[_trigger] call messyEvac_fnc_disableReinforceTrigger;

//Tell our launcher Commander(s) to reinforce
{
	[_x, _units] call messyEvac_fnc_commanderFireOrder;
} forEach _launchersForPosition;

sleep ME_LAUNCHER_TRIGGER_INTERVAL;

//Make the launcher not flagged as busy anymore, change the trigger interval, and 'reset' the trigger condition
// so it can be activated again
_launcher setVariable [ME_LAUNCHER_BUSY_VAR, false];

//Enable the reinforce trigger now that we're 'done'
[_trigger] call messyEvac_fnc_enableReinforceTrigger;

//TODO: Allow multiple launchers to reinforce on called position