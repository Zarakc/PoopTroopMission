#include "launcherConstants.sqf";

//Trigger thisList and trigger itself
params["_units", "_trigger"];

["Reinforce On Point - Called"] call messyEvac_fnc_debugLog;
//Check if the launcher are BIS_fnc_supplydrop
_launcher = missionNamespace getVariable "arty1";

_isLauncherBusy = _launcher getVariable ME_LAUNCHER_BUSY_VAR;

_continue = false;

//Set continue to true if _isLauncherBusy is nil or false
if (isNil "_isLauncherBusy") then {
	[format["Reinforce On Point - _isLauncherBusy is nil, setting to true, and continuing"]] call messyEvac_fnc_debugLog;
	_continue = true;

	//Add launcher to the group the first time this triggers //TODO: Just do on start up of mission
	//Create a group for the launcher to use for its spawned units
	_launcherSpecificGroup = createGroup ME_LAUNCHER_SIDE;

	//Add the launcher to our marked group so artillery shells turn into reinforcements
	[_launcher, _launcherSpecificGroup] call messyEvac_fnc_addLauncherToGroup;

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

	// //Mark the launchers as busy if they are free
	// _launcher setVariable [ME_LAUNCHER_BUSY_VAR, true];

	// //Disable the trigger while we're busy
	// //TODO: Could change the trigger activation to essentially 'deactivate' the trigger so repeatable works
	// _triggerStatements = triggerStatements _trigger;

	// [format["Reinforce On Point - Trigger Activated Before Change - %1", triggerActivated _trigger]] call messyEvac_fnc_debugLog;
	
	// [format["Reinforce On Point - Trigger Condition - %1", _triggerStatements select 0]] call messyEvac_fnc_debugLog;
	
	// [format["Reinforce On Point - Trigger Activation Statement - %1", _triggerStatements select 1]] call messyEvac_fnc_debugLog;

	// //Disable the trigger by overriding the condition
	// _trigger setTriggerStatements ["false", _triggerStatements select 1, ""];//Currently not doing anything for deactivate

	// [format["Reinforce On Point - Trigger Activated After Change - %1", triggerActivated _trigger]] call messyEvac_fnc_debugLog;

	

	// //Get the commander
	// _commander = effectiveCommander _launcher;

	// _tarPos = getPosATL (_units select 0);

	// _adjPos = [_tarPos] call messyEvac_fnc_addCoordinateVariance;

	// //Call in our reinforcements
	// [format["Reinforce On Point - Commanding Artillery Fire - %1", _commander]] call messyEvac_fnc_debugLog;
	
	// //TODO: Have the busy be marked as done when the firing finishes - an execVM call to allow for sleeping?
	// //TODO: Have trigger condition set back once this call finishes
	// _commander commandArtilleryFire [_adjPos, ME_LAUNCHER_ROUND_TYPE, count _units];

	//Set the trigger interval to longer - keeping in mind reinforcements typically take 30-40 seconds to arrive
	//_trigger setTriggerInterval ME_LAUNCHER_TRIGGER_INTERVAL;
} else {
	["Reinforce On Point - Else statement - Continue was false"] call messyEvac_fnc_debugLog;
	//Figure out how to handle things if these are busy
};