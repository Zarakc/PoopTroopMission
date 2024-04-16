#include "launcherConstants.sqf";

//Given marker for spawning units and the index for our loop
params["_spawnMarker", "_i"];

[format["Spawn Launcher - %1 - Spawn Iteration: %2", _spawnMarker, _i]] call messyEvac_fnc_debugLog;

_markerPos set [1, ((_markerPos select 1) + ME_LAUNCHER_SPAWN_DISTANCE)];

[format["Spawn Launcher - %1 - Pos for Spawn: %2", _spawnMarker, _markerPos]] call messyEvac_fnc_debugLog;

_spawnVehicleResults = [_markerPos, _calcDir, ME_LAUNCHER_VEHICLE_TYPE, ME_LAUNCHER_SIDE] call BIS_fnc_spawnVehicle;

_spawnedLauncher = _spawnVehicleResults select 0;

//Create a group for the launcher to use for its spawned units
_launcherSpecificGroup = createGroup ME_LAUNCHER_SIDE;

[format["Spawn Launcher - Created %1 - Group %2", _spawnedLauncher, _launcherSpecificGroup]] call messyEvac_fnc_debugLog;

//Code for getting the launcherArray and adding this entry
[_spawnedLauncher, _launcherSpecificGroup] call messyEvac_fnc_addLauncherToGroup;

//Return the spawnedVehicle
_spawnedLauncher;