#include "poopTroopConstants.sqf";

eventHandlerVehicle = {
	params ["_vehicle", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile"];

	//_bdrmVehicle = missionNamespace getVariable "bdrm_bad_launcher";
	_pooBoys = missionNamespace getVariable "pooBoys";/*[
		missionNamespace getVariable "arty1",
		missionNamespace getVariable "arty2",
		missionNamespace getVariable "arty3",
		missionNamespace getVariable "arty4",
		missionNamespace getVariable "arty5"];*/
	
	[format["init sqf - Received pooboys: %1", _pooBoys]] execVM PT_DEBUG_SQF;

	//TODO: Check if in reads the map, otherwise we need to scan through the first element in each entry
	//pooBoys are formatted like [#key, [vehicle, group]]
	//if (_vehicle in _pooBoys) then {
		
	//forEach _pooBoys;
	({
		_mappedVehicle = _y select 0;
		_poopGroup = _y select 1;

		//If one of our registered pooBoys is firing, then we're firing a pooBoy, ignore otherwise.
		if(_vehicle == _mappedVehicle) then {

			[format["Vehicle matched %1 - Group %2", _vehicle, _poopGroup]] execVM PT_DEBUG_SQF;

			//Get velocity of projectile then set our pod's position to it.
			_projectileVelocity = velocity _projectile;
			_pod = "Land_ToiletBox_F" createVehicle getPos _projectile;
			deleteVehicle _projectile;
			_pod setVelocity _projectileVelocity;

			["InitialPodSequence - Calling podEnrouteSequence"] execVM PT_DEBUG_SQF;
			[_pod, _poopGroup, _vehicle] execVM PT_POD_SEQUENCE_START;
		};
		
	}) forEach _pooBoys;
};

["ace_firedNonPlayerVehicle", eventHandlerVehicle] call CBA_fnc_addEventHandler;