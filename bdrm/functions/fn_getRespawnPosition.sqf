#include "..\constants.sqf";

private _respawnPosition = nil;

//Unit side and callsign for their group
params["_playerGroupName"];

[format ["BDRM Player Group Name Received: %1 ", _playerGroupName]] call BDRM_fnc_diag_log;

_respawnMarkerName = 'NotSet';

if(_playerGroupName isEqualTo BDRM_VEHICLE_RESPAWN_EAST_GROUP) then {
	[format ["BDRM respawn - %1 Section", BDRM_VEHICLE_RESPAWN_EAST_GROUP]] call BDRM_fnc_diag_log;
	_respawnMarkerName = getText(getMissionConfig "BDRMConfig" >> "respawnEastMarkerName");
} else {
	[format ["BDRM respawn - %1 Section", BDRM_VEHICLE_RESPAWN_SOUTH_GROUP]] call BDRM_fnc_diag_log;
	_respawnMarkerName = getText(getMissionConfig "BDRMConfig" >> "respawnSouthMarkerName");
};

[format ["BDRM respawn - MarkerName: %1", _respawnMarkerName]] call BDRM_fnc_diag_log;
_respawnObject = missionNamespace getVariable [_respawnMarkerName , objNull];

if (not isNull _respawnObject || getMarkerType _respawnMarkerName != "") then {
   _respawnPosition = getPos _respawnObject;
   [format ["BDRM respawn - Non-Empty Respawn Position: %1", _respawnPosition]] call BDRM_fnc_diag_log;
} else {
	[format ["BDRM respawn marker/object '%1' not found", _respawnMarkerName]] call BDRM_fnc_diag_log;
};

_respawnPosition
