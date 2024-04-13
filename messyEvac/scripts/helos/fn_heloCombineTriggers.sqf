#include "heloConstants.sqf";

//Combined trigger fires if all spawned helo's for the mission leave the airfield
// this can be physically leaving the area of being destroyed
_heloEscapeTriggers = missionNamespace getVariable PT_HELO_TRIGGERS_VARNAME;

//Figure out how we can grab multiple triggers and add each of them having triggered onto a newly created trigger
_combinedTrigger = createTrigger ["EmptyDetector", /*Don't care about position*/PT_HELO_POS_1];

//Grab the triggerNames from the trigger mission variable
_triggersActivated = [];
_combinedActivatedStr = "";

_triggerCount = count _heloEscapeTriggers;

_haveMultipleTriggers = _triggerCount > 1;

[format["Helo Combine Triggers - Multiple Triggers? %1", _haveMultipleTriggers]] call messyEvac_fnc_debugLog;

//For each of the spawned helo triggers, add that trigger as a variable on the created combined trigger
// so the activation of all the triggers can be used as the final activation for the mission end/spawn end check
{
	_selectedTrigger = _heloEscapeTriggers select _forEachIndex;

	_triggerVarName = PT_HELO_LEAVE_TRIGGER_NAME + str _forEachIndex;

	_combinedTrigger setvariable [_triggerVarName, _selectedTrigger];

	_triggersActivated append [_triggerVarName];

	//triggerActivated check does not need to grab the trigger via missionNamespace
	_combinedActivatedStr = _combinedActivatedStr + "triggerActivated " + _triggerVarName;

	if(_haveMultipleTriggers) then {
		//If we aren't the last trigger, append " && "
		if(_forEachIndex < (_triggerCount - 1)) then {
			_combinedActivatedStr = _combinedActivatedStr + " && ";
		};
	};

} forEach _heloEscapeTriggers;

_combinedActivatedStr = _combinedActivatedStr + ";";

_testTrigger = missionNamespace getVariable "shellForStatements";
_pullStatementStr = (triggerStatements _testTrigger) select 1;

_test = {
		[format["Helo Combined Trigger - Helo Triggers %1 Activated", str (count _heloEscapeTriggers)]] call messyEvac_fnc_debugLog;
		["ace_spectatorSet", ""] call CBA_fnc_remoteEvent;
	};

_combinedTrigger setTriggerStatements [
	/* Condition */ _combinedActivatedStr,
	/* Activated Statement */"[] call messyEvac_fnc_heloEvacTriggered;",
	/* Deactivated Statement */
	""
];

//Might be the line to disable the spectator respawn
// likely would need to also disable the respawn generally for those that were dead
//["ace_spectatorSet", ""] call CBA_fnc_remoteEvent;

[format["Helo Combine Triggers: %1", _combinedActivatedStr]] call messyEvac_fnc_debugLog;

_combinedTrigger;