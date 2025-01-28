#include "..\..\messyEvacuationConstants.sqf";
#include "truckConstants.sqf";

params [];

_eastRespawnVehicleName = getText(getMissionConfig "BDRMConfig" >> "respawnEastMarkerName");
_eastVehicle = missionNamespace getVariable _eastRespawnVehicleName;

_southRespawnVehicleName = getText(getMissionConfig "BDRMConfig" >> "respawnSouthMarkerName");
_southVehicle = missionNamespace getVariable _southRespawnVehicleName;

[format["Damage Respawn Vehicles - %1 and %2", _eastVehicle, _southVehicle]] execVM ME_DEBUG_SQF;

//TODO: FUCK THIS, BOTH SIDES GET A JEEP AND HAVE A DERELICT VEHICLE THAT HELPED GET THEM TO THE START

_respawnVehicles = [_eastVehicle, _southVehicle];

{
	//Nested forEach needs this to be able to reference the correct value
	_currentVehicle = _x;
	
	[format["Damage Respawn Vehicles - Working on %1", _currentVehicle]] execVM ME_DEBUG_SQF;

	//Set up the mini jeep with engine and one-sided wheel damage
	_currentVehicle setHitPointDamage ["hitengine", 0.8];
	[format["Damage Respawn Vehicles - Damaged %1's hitengine", _currentVehicle]] execVM ME_DEBUG_SQF;

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
		[format["Damage Respawn Vehicles - Damaging %1's %2", _currentVehicle, _x]] execVM ME_DEBUG_SQF;
		_currentVehicle setHitPointDamage [_x, 0.9];
	} forEach _wheelScenario;//There is one spare, so it could be used to partially mitigate the wheel dmg

	//After we rough up the vehicle, ensure it doesn't blow up.
	_currentVehicle allowDamage false;
	[format["Damage Respawn Vehicles - %1 is now immune to damage", _currentVehicle]] execVM ME_DEBUG_SQF;
} forEach _respawnVehicles;