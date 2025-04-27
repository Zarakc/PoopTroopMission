#include "messyEvac\messyEvacuationConstants.sqf";
#include "messyEvac\scripts\helos\heloConstants.sqf";

//BDRM SETUP START
params ["_player", "_didJIP"];

[_player] execVM "bdrm\scripts\setup\setupLocalPlayer.sqf";
//BDRM SETUP END

execVM "messyEvac\scripts\messyEvacBriefing.sqf";

if(ME_LOCAL_SCRIPTS == true) then {
	["========= Player Local Mission Init =========="] call messyEvac_fnc_debugLog;
	execVM ME_INITIALIZE_MISSION;
} else {
	"Player Init - Respawn Vic Block" call messyEvac_fnc_debugLog;
	//Get HandleDamage for respawn vic's on players for localization swapping
	private _eastRespawnVehicleName = getText(getMissionConfig "BDRMConfig" >> "respawnEastMarkerName");
	private _eastVehicle = missionNamespace getVariable _eastRespawnVehicleName;

	private _southRespawnVehicleName = getText(getMissionConfig "BDRMConfig" >> "respawnSouthMarkerName");
	private _southVehicle = missionNamespace getVariable _southRespawnVehicleName;

	[format["Damage Respawn Vehicles - Player Addition %1 for HandleDamage on %2", _player, _eastVehicle]] call messyEvac_fnc_debugLog;
	[_eastVehicle] call messyEvac_fnc_addRespawnVicHandleDamage;

	[format["Damage Respawn Vehicles - Player Addition %1 for HandleDamage on %2", _player, _southVehicle]] call messyEvac_fnc_debugLog;
	[_southVehicle] call messyEvac_fnc_addRespawnVicHandleDamage;

};