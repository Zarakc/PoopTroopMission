#include "..\..\messyEvacuationConstants.sqf";
#include "heloConstants.sqf";

//Create a trigger for a spawned helo to trigger when it leaves a certain radius of its spawn
//Each helo trigger is added to a missionNamespace variable used to track each helo trigger

//Called from initializeHelos
params ["_helo", "_i"];

[format["Helo %1 - Creating Trigger", _helo]] call messyEvac_fnc_debugLog;

//Used for saving created trigger into missionNamespace
_varName = PT_HELO_LEAVE_TRIGGER_NAME + str _i;

[format["Helo %1 - Trigger POS: %2", _helo, getPos _helo]] call messyEvac_fnc_debugLog;

_trigger = createTrigger ["EmptyDetector", PT_HELO_AIRFIELD_ZONE_POS];

//NOT PRESENT so when the helo has left the area/been destroyed, it triggers
_trigger setTriggerActivation ["VEHICLE", "NOT PRESENT", false];
_trigger setTriggerArea PT_HELO_AIRFIELD_ZONE_AREA;
_trigger triggerAttachVehicle [_helo];
_trigger setEffectCondition "this";
_trigger setTriggerStatements [
	"this",//Return bool value - Manual one is returning 'this' as the condition
	"[format[""Helo %1 - Leave Triggered"", _helo]] call messyEvac_fnc_debugLog",//"[""Helo Loss"", false, 2] call BIS_fnc_endMission",
	"[""Helo Loss"", false, 2] call BIS_fnc_endMission"
];

missionNameSpace setVariable [_varName, _trigger];
[format["Helo %1 - Trigger %2 Setup - Created var %3", _helo, _i, _varName]] call messyEvac_fnc_debugLog;

//Ensure our triggers mission var exist, or create it if it doesn't, and then append the newly created trigger to it
_heloEscapeTriggers = missionNamespace getVariable PT_HELO_TRIGGERS_VARNAME;

if(isNil "_heloEscapeTriggers") then {

	[format["Helo %1 - Trigger Setup - HeloEscapeTriggers nil, creating entry", _helo]] call messyEvac_fnc_debugLog;
	
	_heloEscapeTriggers = [];
};

_heloEscapeTriggers append [_trigger];

//Actually setting the variable so it can be grabbed is nice
missionNamespace setVariable [PT_HELO_TRIGGERS_VARNAME, _heloEscapeTriggers];

[format["Helo %1 - Trigger Vehicle %2", _helo, triggerAttachedVehicle _trigger]] call messyEvac_fnc_debugLog;
