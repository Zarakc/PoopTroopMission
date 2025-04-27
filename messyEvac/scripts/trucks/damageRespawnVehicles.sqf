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

	[format["Damage Respawn Vehicles - Calling EventHandler Addition for %1", _currentVehicle]] call messyEvac_fnc_debugLog;
	[_currentVehicle] call messyEvac_fnc_addRespawnVicHandleDamage;

} forEach _respawnVehicles;