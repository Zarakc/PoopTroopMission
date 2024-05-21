#include "launcherConstants.sqf";

//Launcher vehicle we're working with and the units we're called to reinforce on top
params["_launcher", "_units"];

//Get the commander
_commander = effectiveCommander _launcher;

_tarPos = getPosATL (_units select 0);

_adjPos = [_tarPos] call messyEvac_fnc_addCoordinateVariance;

//Boolean for if we're in range (testing to see why artyHelo4 doesn't fire)
_inRange = _adjPos inRangeOfArtillery [[_launcher],  ME_LAUNCHER_ROUND_TYPE];

_ammoCount = magazinesAmmo _launcher;

//Call in our reinforcements
[format["Commander Reinforce Order - Commanding Artillery Fire - %1 - In Range: %2 - Ammo Left: %3", _commander, _inRange, _ammoCount]] call messyEvac_fnc_debugLog;

[format["Commander Reinforce Order - Ammo Left: %1", _ammoCount]] call messyEvac_fnc_debugLog;

_commander commandArtilleryFire [_adjPos, ME_LAUNCHER_ROUND_TYPE, count _units];