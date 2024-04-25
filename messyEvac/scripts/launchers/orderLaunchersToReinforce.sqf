#include "launcherConstants.sqf";

//Called from fn_reinforceOnPoint.sqf
//Our reinforcement launchers (the 1st of which being the 'lead'), units in the trigger, and the trigger used to call reinforcements
params["_launchers", "_units", "_trigger"];

//TODO: Set up logging to more easily handle this and not complicate the messages in the code file itself
_ORDER_REINFORCE_DEBUG_HEADER = "Order Launcher To Reinforce";

[format["Order Launcher To Reinforce - Trigger - %1", _trigger]] call messyEvac_fnc_debugLog;

_leadLauncher = _launchers select 0;

//Mark the lead launcher of the grouping as busy and 'disable' our trigger for now
_leadLauncher setVariable [ME_LAUNCHER_BUSY_VAR, true];

//Disable the reinforce trigger we're working with
[_trigger] call messyEvac_fnc_disableReinforceTrigger;

//Tell our launcher Commander(s) to reinforce
{
	[_x, _units] call messyEvac_fnc_commanderFireOrder;
} forEach _launchers;

sleep ME_LAUNCHER_TRIGGER_INTERVAL;

//Make the launcher not flagged as busy anymore, change the trigger interval, and 'reset' the trigger condition
// so it can be activated again
_leadLauncher setVariable [ME_LAUNCHER_BUSY_VAR, false];
//[format["Order Launcher To Reinforce - Lead Launcher - %1 - Now Free", _leadLauncher]] call messyEvac_fnc_debugLog;

//Enable the reinforce trigger now that we're 'done'
[_trigger] call messyEvac_fnc_enableReinforceTrigger;