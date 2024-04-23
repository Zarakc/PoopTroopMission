#include "..\..\messyEvacuationConstants.sqf";
#include "..\pod\podConstants.sqf";
#include "launcherConstants.sqf";

eventHandlerVehicle = {
	params ["_vehicle", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile"];

	_launchers = missionNamespace getVariable ME_LAUNCHER_VARNAME;
	
	[format["Launcher Trigger - Received Launchers: %1", _launchers]] call messyEvac_fnc_debugLog;
		
	//forEach _launcher;
	{
		_mappedVehicle = _x;//was '_y select 0' for when the obj structure was a map
		[format["Launcher Trigger - Vehicle - %1", _vehicle, _unitGroup]] call messyEvac_fnc_debugLog;

		_unitGroup = _mappedVehicle getVariable ME_LAUNCHER_UNITGROUP_VARNAME;//TODO: 04/22/2024 Check this new usage

		//If one of our registered pooBoys is firing, then we're firing a pooBoy, ignore otherwise.
		if(_vehicle == _mappedVehicle) then {

			[format["Launcher Trigger - Vehicle matched %1 - Group %2", _vehicle, _unitGroup]] call messyEvac_fnc_debugLog;

			//Get velocity of projectile then set our pod's position to it.
			_projectileVelocity = velocity _projectile;
			_pod = ME_POD_TYPE createVehicle getPos _projectile;
			deleteVehicle _projectile;
			_pod setVelocity _projectileVelocity;

			["Launcher Trigger - Calling podEnrouteSequence"] call messyEvac_fnc_debugLog;
			[_pod, _unitGroup, _vehicle] execVM PT_POD_SEQUENCE_START;
		};
		
	} forEach _launchers;
};

["ace_firedNonPlayerVehicle", eventHandlerVehicle] call CBA_fnc_addEventHandler;