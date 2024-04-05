#include "..\..\messyEvacuationConstants.sqf";
#include "heloConstants.sqf";

params ["_helo"];

[format["Helo %1 - Creating Trigger", _helo]] execVM PT_DEBUG_SQF;

[format["Helo %1 - Trigger POS: %2", _helo, getPos _helo]] execVM PT_DEBUG_SQF;

_trigger = createTrigger ["EmptyDetector", getPos _helo];//11805.763, 12607.356, 0
//NOT PRESENT so when the helo has left the area, it triggers
_trigger setTriggerActivation ["VEHICLE", "NOT PRESENT", false];//Matches manual trigger
_trigger setTriggerText "Helo Trigger";
_trigger setTriggerArea [5, 5, -1, false];
_trigger triggerAttachVehicle [_helo];//Trigger Vehicle is null it seems
_trigger setEffectCondition "this";
_trigger setTriggerStatements [
	"this",//Return bool value - Manual one is returning 'this' as the condition
	"[""Helo Loss"", false, 2] call BIS_fnc_endMission",
	"[""Helo Loss"", false, 2] call BIS_fnc_endMission"
];
//TODO: Do a print out of the placed trigger in the editor and compare with what is here

[format["Helo %1 - Trigger Vehicle %2", _helo, triggerAttachedVehicle _trigger]] execVM PT_DEBUG_SQF;

[format["Helo %1 - Trigger %2", _helo, _trigger]] execVM PT_DEBUG_SQF;

//Grab the manually made trigger here and output its values
_manualTrigger = missionNamespace getVariable "testHeloTrigger";
_triggerType = triggerType _manualTrigger;
_triggerArea = triggerArea _manualTrigger;

_triggerStatements = triggerStatements _manualTrigger;
_condition = _triggerStatements select 0;
_codeOnActivate = _triggerStatements select 1;
_codeOnDeactivate = _triggerStatements select 2;

_triggerActivation = triggerActivation _manualTrigger;
_activatedBy = _triggerActivation select 0;
_activatedType = _triggerActivation select 1;
_isRepeating = _triggerActivation select 2;

[format["Helo %1 - Manual Trigger Vehicle %2", _helo, triggerAttachedVehicle _manualTrigger]] execVM PT_DEBUG_SQF;
[format["Helo %1 - Manual Trigger Type %2", _helo, _triggerType]] execVM PT_DEBUG_SQF;
[format["Helo %1 - Manual Trigger Area %2", _helo, _triggerArea]] execVM PT_DEBUG_SQF;

[format["Helo %1 - Manual Trigger Condition %2", _helo, _condition]] execVM PT_DEBUG_SQF;
[format["Helo %1 - Manual Trigger Code on Activate %2", _helo, _codeOnActivate]] execVM PT_DEBUG_SQF;
[format["Helo %1 - Manual Trigger Code on Deactive %2", _helo, _codeOnDeactivate]] execVM PT_DEBUG_SQF;

[format["Helo %1 - Manual Trigger Activated By %2", _helo, _activatedBy]] execVM PT_DEBUG_SQF;
[format["Helo %1 - Manual Trigger Activated Type %2", _helo, _activatedType]] execVM PT_DEBUG_SQF;
[format["Helo %1 - Manual Trigger Is Repeating %2", _helo, _isRepeating]] execVM PT_DEBUG_SQF;
//End the grabbing of the manual trigger values
