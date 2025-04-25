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

	//initServer is shown to run before initPlayerLocal as per https://community.bistudio.com/wiki/Initialisation_Order
	//	So the hope is that is all taken care of before this runs
	//Helo EventHandler
	// "Player Init - Helo Block" call messyEvac_fnc_debugLog;
	
	// waitUntil { 
	// 	sleep 2;
	// 	_helos = missionNamespace getVariable ME_HELOS;
	// 	try {//Handling for when _helos is undefined
	// 		[format["Player Init - Helo Block Wait- Helos %1", _helos]] call messyEvac_fnc_debugLog;
	// 		count _helos > 0 
	// 	} catch {
	// 		false
	// 	}
	// };
	// "Player Init - Helo Block - Post Wait" call messyEvac_fnc_debugLog;

	// //TODO: Get working - possibly need to use addMissionEventHandler ["EntityKilled", {...}]?
	// //Not seeing these triggered at all and the server did not trigger its own once helo locality changed
	// private _helos = missionNamespace getVariable ME_HELOS;
	// [format["Player Init - Helo Block - Helos %1", _helos]] call messyEvac_fnc_debugLog;

	// {
	// 	[format["Player Init - Helo Killed EH - Player Addition %1 for HandleDamage on %2", _player, _x]] call messyEvac_fnc_debugLog;
	// 	_x addEventHandler ["Killed", {_x call messyEvac_fnc_heloDestroyed}];
	// } forEach _helos;

};