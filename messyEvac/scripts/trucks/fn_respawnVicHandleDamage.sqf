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

[format["HandleDamage on %1. Check if it is %2 or %3", _dmgedUnit, _eastVehicle, _southVehicle]] call messyEvac_fnc_debugLog;
//We only want this HandleDamage to run for the respawn vehicles
if(_dmgedUnit == _southVehicle or _dmgedUnit == _eastVehicle) then {
	_partHit = _this select 1;
	_damage = _this select 2;
	_dmgSource = _this select 3;//Base HandleDamage this is select 4, with this as a separate function it's only 3

	[format["HandleDamage: %1", _this]] call messyEvac_fnc_debugLog;

	//Saw instances of 0 damage going through the flow, so cutting them off earlier
	//Testing if removal of not targetted
	if(_damage == 0 or _partHit isEqualTo "") then {
		[format["HandleDamage: Skipping - Dmg: %1 Part: %2", _damage, _partHit]] call messyEvac_fnc_debugLog;
		0;//Trying to haave 0 as the return and everything else being in the else block since the skipping wasn't working
	} else {
		
		//If someone drives into the minefield, don't let them make it through the minefield
		if (_dmgSource == "APERSMine_Range_Ammo") then {
			[format["HandleDamage: Hit with: %1 you deserve the %2 damage", _dmgSource, _damage]] call messyEvac_fnc_debugLog;
		} else {
			[format["HandleDamage: %1's %2 being hit for %3", _dmgedUnit, _partHit, _damage]] call messyEvac_fnc_debugLog;

			//Parts don't want to handle dmg normally - essentially cap their dmg
			private _partToDmgMapping = createHashMapFromArray[["hit_engine", 0.8], ["hit_fuel", 0.8], ["wheel_1_1_steering", 0.9], ["wheel_1_2_steering", 0.9], ["wheel_2_1_steering", 0.9], ["wheel_2_2_steering", 0.9]];

			private _dmgMapping = _partToDmgMapping get _partHit;

			//If we don't find a mapping for a capped damage part
			//	Check if we dmg it normally
			if(isNil "_dmgMapping") then {
				[format["HandleDamage: Normal dmg calc for %1", _partHit]] call messyEvac_fnc_debugLog;
			} else {
				[format["HandleDamage: Returning %1 for %2", _dmgMapping, _partHit]] call messyEvac_fnc_debugLog;
				//Could possibly look to run a dmg call on another part to emulate overflow and still cap this part?
				//Only return a value if we want to handle the dmg ourselves
				_dmgMapping;
			};
		};
	};
};