#include "launcherConstants.sqf";

params["_units"];

["Reinforce On Point - Called"] call messyEvac_fnc_debugLog;
//Check if the launcher are BIS_fnc_supplydrop
_launcher = missionNamespace getVariable "arty1";

//Create a group for the launcher to use for its spawned units
_launcherSpecificGroup = createGroup ME_LAUNCHER_SIDE;

//Add the launcher to our marked group so artillery shells turn into reinforcements
[_launcher, _launcherSpecificGroup] call messyEvac_fnc_addLauncherToGroup;

_isLauncherBusy = _launcher getVariable "_busy";

[format["Reinforce On Point - isLauncherBusy: %1", _isLauncherBusy]] call messyEvac_fnc_debugLog;

//isNil "_isLauncherBusy" || _isLauncherBusy == false
if (true) then {

	["Reinforce On Point - Inside If statement"] call messyEvac_fnc_debugLog;

	//Mark the launchers as busy if they are free
	_launcher setVariable ["_busy", true];

	//Get the commander
	_commander = effectiveCommander _launcher;

	_tarPos = getPosATL (_units select 0);

	_adjPos = [_tarPos] call messyEvac_fnc_addCoordinateVariance;

	//Call in our reinforcements
	[format["Reinforce On Point - Commanding Artillery Fire - %1", _commander]] call messyEvac_fnc_debugLog;
	_commander commandArtilleryFire [_adjPos, ME_LAUNCHER_ROUND_TYPE, count _units];
	
	//Done reinforcing, no longer busy
	_launcher setVariable ["_busy", false];

	//TODO: Could change the trigger activation to essentially 'deactivate' the trigger so repeatable works

} else {
	["Reinforce On Point - Else block : ("] call messyEvac_fnc_debugLog;
	[format["Reinforce On Point - isLauncherBusy: %1", _isLauncherBusy]] call messyEvac_fnc_debugLog;
	//Figure out how to handle things if these are busy
};