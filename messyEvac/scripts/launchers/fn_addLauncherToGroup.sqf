#include "launcherConstants.sqf";

//Adds vehicles to the registered launchers group so their rounds are replaced with reinforcements

//Called from fn_spawnLauncher.sqf
params["_spawnedLauncher", "_launcherSpecificGroup"];

_launchers = missionNamespace getVariable ME_LAUNCHER_VARNAME;

if(isNil "_launchers") then {
	_launchers = createHashMap;
};

//Hashmap entry with [#, [created vehicle, created group]]
_launchers insert [[count _launchers, [_spawnedLauncher, _launcherSpecificGroup]]];

missionNamespace setVariable [ME_LAUNCHER_VARNAME, _launchers];

[format["Add Launcher to Group - %1 - Verified Launchers: %2", _spawnMarkerName, _launchers]] call messyEvac_fnc_debugLog;
[format["Add Launcher to Group - %1 - Sent Launchers keys: %2", _spawnMarkerName, keys _launchers]] call messyEvac_fnc_debugLog;

_launchers;