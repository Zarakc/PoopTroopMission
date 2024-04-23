#include "launcherConstants.sqf";

//Adds vehicles to the registered launchers group so their rounds are replaced with reinforcements

//Called from fn_spawnLauncher.sqf
params["_launcher", "_launcherSpecificGroup"];

_launchers = missionNamespace getVariable ME_LAUNCHER_VARNAME;

if(isNil "_launchers") then {
	_launchers = createHashMap;
};

//Hashmap entry with [#, [created vehicle, created group]]
_launchers insert [[count _launchers, [_launcher, _launcherSpecificGroup]]];

missionNamespace setVariable [ME_LAUNCHER_VARNAME, _launchers];

[format["Add Launcher to Group - Verified Launchers: %1", _launchers]] call messyEvac_fnc_debugLog;
[format["Add Launcher to Group - Sent Launchers keys: %1", keys _launchers]] call messyEvac_fnc_debugLog;

_launchers;