#include "truckConstants.sqf";

params ["_unitToGiveEH"];

[format["AddHandleDamage on %1", _unitToGiveEH]] call messyEvac_fnc_debugLog;

_unitToGiveEH addEventHandler ["HandleDamage", {
	//HandleDamage EH initial params
	//Unit, Selection (dmged section), damage, dmg Source/Projectile
	[_this select 0, _this select 1, _this select 2, _this select 4] call messyEvac_fnc_respawnVicHandleDamage; 
}];