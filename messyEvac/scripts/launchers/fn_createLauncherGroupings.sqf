#include "launcherConstants.sqf";

//Helo pad reinforcer group
_leadLauncher = missionNamespace getVariable "arty1";
_launcher2 = missionNamespace getVariable "arty2";
_launcher3 = missionNamespace getVariable "arty3";
_launcher4 = missionNamespace getVariable "arty4";

//Group of predefined launchers that are grouped for reinforcing the helo landing pad areas
_ME_LAUNCHER_HELO_LAUNCHERS = [_leadLauncher, _launcher2, _launcher3, _launcher4];
missionNamespace setVariable [ME_LAUNCHER_HELO_REINFORCERS, [_leadLauncher, _launcher2, _launcher3, _launcher4]];

_launcherGarage = missionNamespace getVariable "artyGarage1";

_ME_LAUNCHER_GARAGE_LAUNCHERS = [_launcherGarage];
missionNamespace setVariable [ME_LAUNCHER_GARAGE_REINFORCERS, [_launcherGarage]];

_allLauncherGroups = [_ME_LAUNCHER_HELO_LAUNCHERS, _ME_LAUNCHER_GARAGE_LAUNCHERS];

_allLauncherKeys = [ME_LAUNCHER_HELO_REINFORCERS, ME_LAUNCHER_GARAGE_REINFORCERS];

//For each group of specifically targetted reinforcement launchers, give them a unit group
{
	_launcherSpecificGroup = createGroup ME_LAUNCHER_SIDE;

	//For each launcher, add it to our whitelist to replace their rounds with reinforcements
	//Also adds the group variable to the launcher itself
	[_x, _launcherSpecificGroup] call messyEvac_fnc_addLaunchersToGroup;
} forEach _allLauncherKeys;

//_whiteListedLaunchers = missionNamespace getVariable ME_LAUNCHER_VARNAME;
//[format["Create Launcher Groupings - Cleared Launchers: %1", _whiteListedLaunchers]] call messyEvac_fnc_debugLog;

["Create Launcher Groupings - Added launchers to whitelist"] call messyEvac_fnc_debugLog;