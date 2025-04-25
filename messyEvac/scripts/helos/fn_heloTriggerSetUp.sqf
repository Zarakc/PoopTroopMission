#include "..\..\messyEvacuationConstants.sqf";
#include "heloConstants.sqf";

//Create a trigger for a spawned helo to trigger when it leaves a certain radius of its spawn
//Each helo trigger is added to a missionNamespace variable used to track each helo trigger

//Called from initializeHelos
params ["_helo", "_i"];

[format["Helo Trigger Setup - %1", _helo]] call messyEvac_fnc_debugLog;

//Used for saving created trigger into missionNamespace
private _varName = ME_HELO_LEAVE_TRIGGER_NAME + str _i;

[format["Helo Trigger Setup - %1 - Trigger POS: %2", _helo, getPos _helo]] call messyEvac_fnc_debugLog;

private _trigger = createTrigger ["EmptyDetector", ME_HELO_AIRFIELD_ZONE_POS];

//NOT PRESENT so when the helo has left the area/been destroyed, it triggers
_trigger setTriggerActivation ["VEHICLE", "NOT PRESENT", false];
_trigger setTriggerArea ME_HELO_AIRFIELD_ZONE_AREA;
_trigger setTriggerInterval 2;
_trigger triggerAttachVehicle [_helo];

//Trying to add a delay in the hopes that 'alive' reaches eventual consistency
_trigger setTriggerTimeout[5, 7, 10, false];

_trigger setTriggerStatements [
	"this",//Activate trigger bool condition
	"[thisTrigger] call messyEvac_fnc_heloSingleEvac",//Activation code
	""//Deactivation code
];

missionNameSpace setVariable [_varName, _trigger];
[format["Helo Trigger Setup - %1 - Trigger %2 Setup - Created var %3", _helo, _i, _varName]] call messyEvac_fnc_debugLog;

//Ensure our triggers mission var exist, or create it if it doesn't, and then append the newly created trigger to it
private _heloEscapeTriggers = missionNamespace getVariable ME_HELO_TRIGGERS_VARNAME;

if(isNil "_heloEscapeTriggers") then {

	[format["Helo Trigger Setup - %1 - HeloEscapeTriggers nil, creating entry", _helo]] call messyEvac_fnc_debugLog;
	
	_heloEscapeTriggers = [];
};

_heloEscapeTriggers append [_trigger];

//Actually setting the variable so it can be grabbed is nice
missionNamespace setVariable [ME_HELO_TRIGGERS_VARNAME, _heloEscapeTriggers];

[format["Helo Trigger Setup - Trigger %1 - Helo %2 - Trigger Vehicle %3", _trigger, _helo, triggerAttachedVehicle _trigger]] call messyEvac_fnc_debugLog;
