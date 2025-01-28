#include "..\constants.sqf";

private _respawnPosition = nil;

//Unit side and callsign for their group
params["_playerGroupName"];

[format ["BDRM Player Group Name Received: %1 ", _playerGroupName]] call BDRM_fnc_diag_log;

_respawnMarkerName = 'NotSet';

//Verify which group we're doing a respawn for so we know which respawn vehicle to utilize
if(_playerGroupName isEqualTo BDRM_VEHICLE_RESPAWN_EAST_GROUP) then {
	[format ["BDRM respawn - %1 Section", BDRM_VEHICLE_RESPAWN_EAST_GROUP]] call BDRM_fnc_diag_log;
	_respawnMarkerName = getText(getMissionConfig "BDRMConfig" >> "respawnEastMarkerName");
} else {
	[format ["BDRM respawn - %1 Section", BDRM_VEHICLE_RESPAWN_SOUTH_GROUP]] call BDRM_fnc_diag_log;
	_respawnMarkerName = getText(getMissionConfig "BDRMConfig" >> "respawnSouthMarkerName");
};

[format ["BDRM respawn - MarkerName: %1", _respawnMarkerName]] call BDRM_fnc_diag_log;
_respawnObject = missionNamespace getVariable [_respawnMarkerName , objNull];

if (not isNull _respawnObject ) then {
   _respawnPosition = getPos _respawnObject;
} else {
	if (getMarkerType _respawnMarkerName != "") then {
		_respawnPosition = getMarkerPos _respawnMarkerName;
	} else {		
		[format ["BDRM respawn marker/object %1 not found", _respawnMarkerName]] call BDRM_fnc_diag_log;
	};
};

_respawnPosition