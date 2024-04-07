#include "heloConstants.sqf";

//TODO: Helos are created, now we create our trigger that will be conditional on all the helo leave area triggers to be activated
_heloEscapeTriggers = missionNamespace getVariable PT_HELO_TRIGGERS_VARNAME;

//Figure out how we can grab multiple triggers and add each of them having triggered onto a newly created trigger
_combinedTrigger = createTrigger ["EmptyDetector", /*Don't care about position*/PT_HELO_POS_1];

//Grab the triggerNames from the trigger mission variable
_triggersActivated = [];
private _combinedActivatedStr = "";

_triggerCount = count _heloEscapeTriggers;

private _haveMultipleTriggers = _triggerCount > 1;

[format["Helo Combine Triggers - Multiple Triggers? %1", _haveMultipleTriggers]] call messyEvac_fnc_debugLog;

//For each of the spawned helo triggers, add that trigger as a variable on the created combined trigger
// so the activation of all the triggers can be used as the final activation for the mission end/spawn end check
{
	private _selectedTrigger = _heloEscapeTriggers select _forEachIndex;

	private _triggerName = triggerText _selectedTrigger;

	_triggerVarName = "heloLeaveTrigger" + str _forEachIndex;

	_combinedTrigger setvariable [_triggerVarName, _selectedTrigger];

	_triggersActivated append [_triggerVarName];

	//TODO: Figure out best way to get the '&&' between trigger activated clauses
	//Mod 2 might be the usage
	_combinedActivatedStr = _combinedActivatedStr + "triggerActivated " + /*"getVariable " +*/ _triggerVarName;
	[format["Helo Combine Triggers - Test: %1", _combinedActivatedStr]] call messyEvac_fnc_debugLog;

	if(_haveMultipleTriggers) then {
		["Helo Combine Triggers - Multiple Triggers If Block"] call messyEvac_fnc_debugLog;

		//If we aren't the last trigger, append " && "
		if(_forEachIndex < (_triggerCount - 1)) then {
			_combinedActivatedStr = _combinedActivatedStr + " && ";
			[format["Helo Combine Triggers - Test: %1", _combinedActivatedStr]] call messyEvac_fnc_debugLog;
		};
	};

} forEach _heloEscapeTriggers;

//TODO: Getting an error for a missing ';', so we'll see
_combinedActivatedStr = _combinedActivatedStr + ";";

_combinedTrigger setTriggerStatements [
	/* Condition */ _combinedActivatedStr,//triggerActivated (_heloEscapeTriggers select 0)
	/* Activated Statement */
	"[format[""Helo Combined Trigger - Helo Triggers %1 Activated"", (count _heloEscapeTriggers)]] call messyEvac_fnc_debugLog",
	/* Deactivated Statement */
	""
];//[""Helo Loss"", false, 2] call BIS_fnc_endMission

[format["Helo Combine Triggers: %1", _combinedActivatedStr]] call messyEvac_fnc_debugLog;

_combinedTrigger;
/*
_trg settriggerstatement ["(thistrigger getVariable 'myvar' ) distance thistrigger", "",""];

_trg setvariable ['myvar', chopper1];
*/