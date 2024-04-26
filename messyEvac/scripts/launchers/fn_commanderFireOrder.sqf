#include "launcherConstants.sqf";

//Launcher vehicle we're working with and the units we're called to reinforce on top
params["_launcher", "_units"];

//Get the commander
_commander = effectiveCommander _launcher;

_tarPos = getPosATL (_units select 0);

_adjPos = [_tarPos] call messyEvac_fnc_addCoordinateVariance;

//Call in our reinforcements
[format["Commander Reinforce Order - Commanding Artillery Fire - %1", _commander]] call messyEvac_fnc_debugLog;

_commander commandArtilleryFire [_adjPos, ME_LAUNCHER_ROUND_TYPE, count _units];