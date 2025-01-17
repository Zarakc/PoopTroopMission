#include "launcherConstants.sqf";

//Launcher vehicle we're working with and the units we're called to reinforce on top
params["_launcher", "_units"];

//Get the commander
_commander = effectiveCommander _launcher;

//Get the pos of randomly selected member
_target = selectRandom _units;
_tarPos = getPosATL _target;

_adjPos = [_tarPos] call messyEvac_fnc_addCoordinateVariance;

//Boolean for if we're in range (testing to see why artyHelo4 doesn't fire)
_inRange = _adjPos inRangeOfArtillery [[_launcher],  ME_LAUNCHER_ROUND_TYPE];
[format["Commander Reinforce Order - Commanding Artillery Fire - %1 - In Range: %2", _commander, _inRange]] call messyEvac_fnc_debugLog;

//Ammo replenishment is working - keeping logs and vars for any future reference usage
//_ammoCount = magazinesAmmo _launcher;
//[format["Commander Reinforce Order - Ammo Left: %1", _ammoCount]] call messyEvac_fnc_debugLog;


//Add ammo in the amount we're about to fire
_launcher setVehicleAmmoDef 1;//Fully reload the vehicle


//_ammoCount = magazinesAmmo _launcher;
//[format["Commander Reinforce Order - Ammo Count Now: %1", _ammoCount]] call messyEvac_fnc_debugLog;

_commander commandArtilleryFire [_adjPos, ME_LAUNCHER_ROUND_TYPE, count _units];