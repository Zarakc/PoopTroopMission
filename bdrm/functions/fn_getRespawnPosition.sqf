#include "..\constants.sqf";

private _respawnPosition = nil;

//Unit side and callsign for their group
params["_playerGroupName"];

[format ["BDRM Player Group Name Received: %1 ", _playerGroupName]] call BDRM_fnc_diag_log;

_respawnMarkerName = 'NotSet';

//TODO: Validate this works with a new East Overflow
//Verify if we're respawning an East or South group member
private _isEast = [BDRM_EAST_GROUP_MARKER, _playerGroupName] call BIS_fnc_inString;

if(_isEast) then {
	[format ["BDRM respawn - %1 Section", BDRM_EAST_GROUP_MARKER]] call BDRM_fnc_diag_log;
	_respawnMarkerName = getText(getMissionConfig "BDRMConfig" >> BDRM_EAST_VEHICLE_MARKER_NAME);//TODO: Verify this works with a cosnt
} else {
	[format ["BDRM respawn - %1 Section", BDRM_SOUTH_GROUP_MARKER]] call BDRM_fnc_diag_log;
	_respawnMarkerName = getText(getMissionConfig "BDRMConfig" >> BDRM_SOUTH_VEHICLE_MARKER_NAME);
};

[format ["BDRM respawn - MarkerName: %1", _respawnMarkerName]] call BDRM_fnc_diag_log;
_respawnObject = missionNamespace getVariable _respawnMarkerName;//TODO: Test simplified syntax

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