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

	//Test out onHit to see if we can mitigate teh damage without making the vehicle immune

	//If the provided code returns a numeric value, 
	//	this value will overwrite the default damage of given selection after processing. 
	//If no value is returned, the default damage processing will be done - 
	//	this allows for safe stacking of this event handler.
	_currentVehicle addEventHandler ["HandleDamage", {
		_unit = _this select 0;
		_partHit = _this select 1;
		_damage = _this select 2;
		//[format["DRV - HandleDamage: %1", _this]] call messyEvac_fnc_debugLog;

		if(_damage == 0) then {return};

		[format["HandleDamage: %1's %2 being hit for %3", _unit, _partHit, _damage]] call messyEvac_fnc_debugLog;

		//Parts we have (likely) already damaged that we want to not break/heal
		private _partToDmgMapping = createHashMapFromArray[["hit_engine", 0.8], ["wheel_1_1_steering", 0.9], ["wheel_1_2_steering", 0.9], ["wheel_2_1_steering", 0.9], ["wheel_2_2_steering", 0.9]];
		
		//TODO: Decide if fuel should be handled normally
		//Parts we want to be damaged normally
		private _partsToDmgNormally = ["spare1", "door11", "door12", "door21", "door22", "hood1", "hit_fuel"];

		private _dmgMapping = _partToDmgMapping get _partHit;

		//Tried to use str wrapping since isNil doesn't like, doesn't work how I want
		//isNull doesn't work - trying _dmgMapping isEqualTo objNull
		if(_dmgMapping isEqualTo objNull) then {

			if(_partHit in _partsToDmgNormally) then {
				[format["HandleDamage: Normal dmg calc for %1", _partHit]] call messyEvac_fnc_debugLog;
				//Not even using 'return;' since that qualifies as us handling the dmg instead of it being interpretted as no value returned so the game handles it
			} else {
				[format["HandleDamage: Hit Not Found %1", _partHit]] call messyEvac_fnc_debugLog;
				//Not even using 'return;' since that qualifies as us handling the dmg instead of it being interpretted as no value returned so the game handles it
			};
		} else {
			[format["HandleDamage: Returning %1 for %2", _dmgMapping, _partHit]] call messyEvac_fnc_debugLog;
			//Only return a value if we want to handle the dmg ourselves
			_dmgMapping;
		};
	}];

	//Dammaged had the hitPoint named used for setDmg on vehicle components
	// _currentVehicle addEventHandler ["Dammaged", {
	// 	//params ["_unit", "_selection", "_damage", "_hitIndex", "_hitPoint", "_shooter", "_projectile"];
	// 	_unit = _this select 0;
	// 	_damage = _this select 2;

	// 	[format["Damage Respawn Vehicles - Dammaged: %1", _this]] call messyEvac_fnc_debugLog;


	// 	//TODO: Check if certain parts of the vehicle can be maintained to a certain %
	// 	//	Vehicle part dmg might not affect its setDamage
	// 	// if ((damage _unit + _damage) <= 0.7) then {
	// 	// 	_unit setDamage (damage _unit) + _damage;
	// 	// } else {
	// 	// 	return;
	// 	// };
	// }];

	/* HitPart event mapping
	[
		[
			bdrm_southRespawn,	//target
			B South Spectre:7 (Zarakc),	//shooter
			2233466: tracer_red.p3d uk3cb_556x45_Ball_red,	//damage source
			[12080.9,11984.3,115.166],	//PosASL of impact
			[676.268,634.076,-73.4165],	//Impact velocity
			[""hit_engine""],	//hit section
			[9,0,0,0,""uk3cb_556x45_Ball_red""],	//Hit data [hitValue, indirectHitValue, indirectHitRange, Explosive Dmg, AmmoClass]
			[0.209778,-0.977746,0.00265596], //Hit surface surfaceNormal
			0.761373, //Radius of component hit
			""a3\data_f\penetration\metal.bisurf"", //SurfaceType hit
			true, //splash dmg
			B South Spectre:7 (Zarakc)
		]
	] 
	*/
	// _currentVehicle addEventHandler ["HitPart", {
	// 	//params ["_target", "_shooter", "_projectile", "_position", "_velocity", "_selection", "_ammo", "_vector", "_radius", "_surfaceType", "_isDirect", "_instigator"];
		
	// 	[format["DRV - HitPart called with: %1", _this]] call messyEvac_fnc_debugLog;

	// 	_triggerData = _this select 0;
	// 	_vehicleHit = _triggerData select 0;

	// 	[format["DRV - HitPart called for: %1", _vehicleHit]] call messyEvac_fnc_debugLog;

	// 	//Part hit is stored in an array
	// 	_partsHit = _triggerData select 5;
	// 	[format["DRV - HitPart on: %1", _partHit]] call messyEvac_fnc_debugLog;

	// 	_hpd = _vehicleHit getHitPointDamage "hitengine";
	// 	[format["DRV - HitPart Engine HPD: %1", _hpd]] call messyEvac_fnc_debugLog;

	// 	_partHit = _partsHit findIf {_x == "hit_engine"};

	// 	if(_partHit != -1) then {
	// 		if(_hpd >= 0.8) then {
	// 			_vehicleHit setHitPointDamage ["hitengine", 0.8];//This did not appear to be occurring, or engine was being damaged otherwise
	// 			_newHpd = _vehicleHit getHitPointDamage "hitengine";
				
	// 			[format["DRV - HitPart Engine Dmg: %1 Restored to %2", _hpd, _newHpd]] call messyEvac_fnc_debugLog;
	// 		};

	// 		return;
	// 	};

	// 	_locationHit = _triggerData select 5;
	// 	[format["DRV - HitPart on: %1", _locationHit]] call messyEvac_fnc_debugLog;

	// 	//_damage = _hitter select 0;
		
	// 	//[format[" - HitPart: %1 being hit for %2", _selection, _damage]] call messyEvac_fnc_debugLog;

	// }];

	//After we rough up the vehicle, ensure it doesn't blow up.
	//_currentVehicle allowDamage false;
	//[format["Damage Respawn Vehicles - %1 is now immune to damage", _currentVehicle]] call messyEvac_fnc_debugLog;
} forEach _respawnVehicles;