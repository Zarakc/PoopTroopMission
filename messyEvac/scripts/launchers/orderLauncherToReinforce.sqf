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

_launchers = _launcherGroupings get 0;//TODO: Parameterize the group to grab
[format["Order Launcher To Reinforce - Launchers - %1", _launchers]] call messyEvac_fnc_debugLog;//Error Undefined variable in expression: _launchers
[format["Order Launcher To Reinforce - Lead Launcher - %1", _launchers get 0]] call messyEvac_fnc_debugLog;//Was using 'select' instead of 'get'

//Mark the launcher as busy and 'disable' our trigger for now
_launcher setVariable [ME_LAUNCHER_BUSY_VAR, true];

//Disable the reinforce trigger we're working with
[_trigger] call messyEvac_fnc_disableReinforceTrigger;

//Tell our launcher Commander to reinforce
[_launcher, _units] call messyEvac_fnc_commanderFireOrder;

sleep ME_LAUNCHER_TRIGGER_INTERVAL;

//Make the launcher not flagged as busy anymore, change the trigger interval, and 'reset' the trigger condition
// so it can be activated again
_launcher setVariable [ME_LAUNCHER_BUSY_VAR, false];

//Enable the reinforce trigger now that we're 'done'
[_trigger] call messyEvac_fnc_enableReinforceTrigger;

// _trigger setTriggerInterval ME_LAUNCHER_TRIGGER_INTERVAL;

// [format["Order Launcher To Reinforce - Trigger Interval Post Change: %1", str (triggerInterval _trigger)]] call messyEvac_fnc_debugLog;

// //'Renable' the trigger by setting the condition back to its original value
// _trigger setTriggerStatements [ME_LAUNCHER_REINFORCE_CONDITION, _triggerStatements select 1, _triggerStatements select 2];

// [_trigger, "Order Launcher To Reinforce", "Reactivation"] call messyEvac_fnc_outputTriggerStatements;

//TODO: Check ammo count after reinforce - might need to make that unlimited/a set amount per vehicle


//TODO: Allow multiple launchers to reinforce on called position