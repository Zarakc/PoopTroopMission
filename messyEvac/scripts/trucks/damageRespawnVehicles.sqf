#include "..\..\messyEvacuationConstants.sqf";
#include "truckConstants.sqf";

params [];

_eastRespawnVehicleName = getText(getMissionConfig "BDRMConfig" >> "respawnEastMarkerName");
_eastVehicle = missionNamespace getVariable _eastRespawnVehicleName;

_southRespawnVehicleName = getText(getMissionConfig "BDRMConfig" >> "respawnSouthMarkerName");
_southVehicle = missionNamespace getVariable _southRespawnVehicleName;

[format["Damage Respawn Vehicles - %1 and %2", _eastVehicle, _southVehicle]] call messyEvac_fnc_debugLog;

_respawnVehicles = [_eastVehicle, _southVehicle];

{
	//Nested forEach needs this to be able to reference the correct value
	_currentVehicle = _x;
	
	[format["Damage Respawn Vehicles - Working on %1", _currentVehicle]] call messyEvac_fnc_debugLog;

	//Set up the mini jeep with engine and one-sided wheel damage
	_currentVehicle setHitPointDamage ["hitengine", 0.8];
	[format["Damage Respawn Vehicles - Damaged %1's hitengine", _currentVehicle]] call messyEvac_fnc_debugLog;

	_frontLeftWheels = ["hitlfwheel"];
	_frontRightWheel = ["hitrfwheel"];

	_leftSideWheels = ["hitlfwheel", "hitlf2wheel"];
	_rightSideWheels = ["hitrfwheel", "hitrf2wheel"];

	//25% Chance for scenario with both sided wheels being damaged
	_leftWheelScenario = [_frontLeftWheels, _frontLeftWheels, _frontLeftWheels, _leftSideWheels];
	//Don't know if we try to harm a vehicle spot that doesn't exist would be an issue or not
	_rightWheelScenario = [_frontRightWheel, _frontRightWheel, _frontRightWheel, _rightSideWheels];


	_wheelSideScenarios = [_leftWheelScenario, _rightWheelScenario];
	//Select one of the side scenarios to select from
	_selectedScenarioArray = selectRandom _wheelSideScenarios;
	//Get one of the wheel arrays from the side scenarios
	_wheelScenario = selectRandom _selectedScenarioArray;

	{
		[format["Damage Respawn Vehicles - Damaging %1's %2", _currentVehicle, _x]] call messyEvac_fnc_debugLog;
		_currentVehicle setHitPointDamage [_x, 0.9];
	} forEach _wheelScenario;//There is one spare, so it could be used to partially mitigate the wheel dmg

	//Fuel scenarios for respawn vehicles
	private _fuelAmountScenarios = [0.17, 0.14, 0.11, 0.008, 0.007];
	private _fuelSetAmount = selectRandom _fuelAmountScenarios;
	_currentVehicle setFuel _fuelSetAmount;

	//TODO: EventHandler doesn't play nice in a hosted server since it needs to execute on the 'owner' of the vehicle's PC
	//	The owner changes during the run, usu. the person to last drive it
	//If the provided code returns a numeric value, 
	//	this value will overwrite the default damage of given selection after processing. 
	//If no value is returned, the default damage processing will be done - 
	//	this allows for safe stacking of this event handler.
	[format["Damage Respawn Vehicles - Calling EventHandler Addition for %1", _currentVehicle]] call messyEvac_fnc_debugLog;
	[_currentVehicle] call messyEvac_fnc_addRespawnVicHandleDamage;
	// _currentVehicle addEventHandler ["HandleDamage", {
	// 	_unit = _this select 0;
	// 	_partHit = _this select 1;
	// 	_damage = _this select 2;
	// 	_dmgSource = _this select 4;

	// 	[format["HandleDamage: %1", _this]] call messyEvac_fnc_debugLog;

	// 	//Saw instances of 0 damage going through the flow, so cutting them off earlier
	// 	//Testing if removal of not targetted
	// 	if(_damage == 0 or _partHit isEqualTo "") then {
	// 		[format["HandleDamage: Skipping - Dmg: %1 Part: %2", _damage, _partHit]] call messyEvac_fnc_debugLog;
	// 		0;//Trying to haave 0 as the return and everything else being in the else block since the skipping wasn't working
	// 	} else {
			
	// 		//If someone drives into the minefield, don't let them make it through the minefield
	// 		if (_dmgSource == "APERSMine_Range_Ammo") then {
	// 			[format["HandleDamage: Hit with: %1 you deserve the %2 damage", _dmgSource, _damage]] call messyEvac_fnc_debugLog;
	// 		} else {
	// 			[format["HandleDamage: %1's %2 being hit for %3", _unit, _partHit, _damage]] call messyEvac_fnc_debugLog;

	// 			//Parts don't want to handle dmg normally - essentially cap their dmg
	// 			private _partToDmgMapping = createHashMapFromArray[["hit_engine", 0.8], ["hit_fuel", 0.8], ["wheel_1_1_steering", 0.9], ["wheel_1_2_steering", 0.9], ["wheel_2_1_steering", 0.9], ["wheel_2_2_steering", 0.9]];

	// 			private _dmgMapping = _partToDmgMapping get _partHit;

	// 			//If we don't find a mapping for a capped damage part
	// 			//	Check if we dmg it normally
	// 			if(isNil "_dmgMapping") then {
	// 				[format["HandleDamage: Normal dmg calc for %1", _partHit]] call messyEvac_fnc_debugLog;
	// 			} else {
	// 				[format["HandleDamage: Returning %1 for %2", _dmgMapping, _partHit]] call messyEvac_fnc_debugLog;
	// 				//Could possibly look to run a dmg call on another part to emulate overflow and still cap this part?
	// 				//Only return a value if we want to handle the dmg ourselves
	// 				_dmgMapping;
	// 			};
	// 		};
	// 	};
	// }];

} forEach _respawnVehicles;