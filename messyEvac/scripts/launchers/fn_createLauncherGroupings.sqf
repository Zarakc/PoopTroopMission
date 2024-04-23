#include "launcherConstants.sqf";

_leadLauncher = missionNamespace getVariable "arty1";
_launcher2 = missionNamespace getVariable "arty2";
_launcher3 = missionNamespace getVariable "arty3";
_launcher4 = missionNamespace getVariable "arty4";

_launchers = [_leadLauncher, _launcher2, _launcher3, _launcher4];

//TODO: Sort out the group handling - Does having one group for a set of launchers work?
_launcherSpecificGroup = createGroup ME_LAUNCHER_SIDE;

//For each launcher, add it to our whitelist to replace their rounds with reinforcements
{
	//Trying _x instead of assigning with 'select _forEachIndex
	[_x, _launcherSpecificGroup] call messyEvac_fnc_addLauncherToGroup;

} forEach _launchers;

//Grab our existing groupings, if present
_launcherGroupings = missionNamespace getVariable ME_LAUNCHER_GROUPINGS_VARNAME;

if(isNil "_launcherGroupings") then {
	["Create Launcher Groupings - nil launcherGroupings, creating hashMap"] call messyEvac_fnc_debugLog;
	_launcherGroupings = createHashMap;
};

//Hashmap entry with [#, [created vehicle, created group]]
_launcherGroupings insert [[0, _launchers]];

missionNamespace setVariable [ME_LAUNCHER_GROUPINGS_VARNAME, _launcherGroupings];

["Create Launcher Groupings - Inserted launcherGroupings"] call messyEvac_fnc_debugLog;