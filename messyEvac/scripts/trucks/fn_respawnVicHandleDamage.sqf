#include "truckConstants.sqf";

//Handle Damage Event Handler Code
//Vehicles will cap dmg to core parts - everything else is handled normally
//Vehicle SHOULD be mostly immune to being destroyed
//Handling empty parts hit with no dmg solved the known vehicle still blowing up states
params ["_dmgedUnit"];

_dmgedUnit = _this select 0;

//TODO: DO WE EVEN NEED TO CHECK THIS IF IT'S ONLY THE VEHICLE ITSELF HAS THE HANDLER?
_eastRespawnVehicleName = getText(getMissionConfig "BDRMConfig" >> "respawnEastMarkerName");
_eastVehicle = missionNamespace getVariable _eastRespawnVehicleName;

_southRespawnVehicleName = getText(getMissionConfig "BDRMConfig" >> "respawnSouthMarkerName");
_southVehicle = missionNamespace getVariable _southRespawnVehicleName;

//If the provided code returns a numeric value, 
//	this value will overwrite the default damage of given selection after processing. 
//If no value is returned, the default damage processing will be done - 
//	this allows for safe stacking of this event handler.

[format["HandleDamage on %1. Check if it is %2 or %3", _dmgedUnit, _eastVehicle, _southVehicle]] call messyEvac_fnc_debugLog;
//We only want this HandleDamage to run for the respawn vehicles
if(_dmgedUnit == _southVehicle or _dmgedUnit == _eastVehicle) then {
	_partHit = _this select 1;
	_damage = _this select 2;
	_dmgSource = _this select 3;//Base HandleDamage this is select 4, with this as a separate function it's only 3

	[format["HandleDamage: %1", _this]] call messyEvac_fnc_debugLog;

	//Instances without parts can still blow up the vehicle
	if(_damage == 0 or _partHit isEqualTo "") then {
		//[format["HandleDamage: Skipping - Dmg: %1 Part: %2", _damage, _partHit]] call messyEvac_fnc_debugLog;
		0;//No damage
	} else {
		
		//If someone drives into the minefield, don't let them make it through the minefield
		if (_dmgSource == "APERSMine_Range_Ammo") then {
			//[format["HandleDamage: Hit with: %1 you deserve the %2 damage", _dmgSource, _damage]] call messyEvac_fnc_debugLog;
		} else {
			//[format["HandleDamage: %1's %2 being hit for %3", _dmgedUnit, _partHit, _damage]] call messyEvac_fnc_debugLog;

			private _partToDmgMapping = createHashMapFromArray[["hit_engine", 0.8], ["hit_fuel", 0.8], ["wheel_1_1_steering", 0.9], ["wheel_1_2_steering", 0.9], ["wheel_2_1_steering", 0.9], ["wheel_2_2_steering", 0.9]];

			private _dmgMapping = _partToDmgMapping get _partHit;

			//If we don't find a mapping for a capped damage part it takes damage normally
			if(isNil "_dmgMapping") then {
				//[format["HandleDamage: Normal dmg calc for %1", _partHit]] call messyEvac_fnc_debugLog;
			} else {
				//[format["HandleDamage: Returning %1 for %2", _dmgMapping, _partHit]] call messyEvac_fnc_debugLog;
				_dmgMapping;
			};
		};
	};
};