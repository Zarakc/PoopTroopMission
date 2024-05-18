#include "..\..\messyEvacuationConstants.sqf";
#include "..\pod\podConstants.sqf";
#include "launcherConstants.sqf";

eventHandlerVehicle = {
	params ["_vehicle", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile"];

	_launchers = missionNamespace getVariable ME_LAUNCHER_VARNAME;
	
	//[format["Launcher Trigger - Received Launchers: %1", _launchers]] call messyEvac_fnc_debugLog;
	
	_isFoundIndex = _launchers findIf { _x == _vehicle};
	//TODO: Hashmap for unregistered vehicles to avoid referencing launchers array each time?

	if(_isFoundIndex != -1) then {
		_matchedVehicle = _launchers select _isFoundIndex;

		_unitGroup = _matchedVehicle getVariable ME_LAUNCHER_UNITGROUP_VARNAME;
		[format["Launcher Trigger - (findId) Vehicle matched %1 - Group %2", _vehicle, _unitGroup]] call messyEvac_fnc_debugLog;

		//Get velocity of projectile then set our pod's position to it.
		_projectileVelocity = velocity _projectile;
		_pod = ME_POD_TYPE createVehicle getPos _projectile;
		deleteVehicle _projectile;
		_pod setVelocity _projectileVelocity;

		["Launcher Trigger - Calling podEnrouteSequence"] call messyEvac_fnc_debugLog;
		[_pod, _unitGroup, _vehicle] execVM PT_POD_SEQUENCE_START;
	};
};

["ace_firedNonPlayerVehicle", eventHandlerVehicle] call CBA_fnc_addEventHandler;