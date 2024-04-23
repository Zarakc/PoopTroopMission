#include "launcherConstants.sqf";

//Adds vehicles to the registered launchers group so their rounds are replaced with reinforcements
//The ME_LAUNCHER_VARNAME mission variable is used by the launcherAceEvent.sqf to do the reinforcement replacement
// It is dependent on each vehicle having the reinforcement unit it supplies saved to the launcher vehicle itself

//Called from fn_spawnLauncher.sqf
params["_groupedLaunchers", "_launcherSpecificGroup"];

_launchers = missionNamespace getVariable ME_LAUNCHER_VARNAME;

if(isNil "_launchers") then {
	_launchers = [];
};

//For each launcher, give them their unit group variable
{
	_x setVariable [ME_LAUNCHER_UNITGROUP_VARNAME, _launcherSpecificGroup];
} forEach _groupedLaunchers;

//Array for all whitelsited launchers]
_launchers append _groupedLaunchers;//Might need to loop

missionNamespace setVariable [ME_LAUNCHER_VARNAME, _launchers];

[format["Add Launcher to Group - Verified Launchers: %1", _launchers]] call messyEvac_fnc_debugLog;

_launchers;