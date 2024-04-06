#include "..\..\messyEvacuationConstants.sqf";
#include "heloConstants.sqf";

//Called from messyEvacuationMissionInitialization
params ["_playerCount"];

[format["Helo - Player count %1", _playerCount]] execVM PT_DEBUG_SQF;

_heloSeatCount = [PT_TRANSIT_HELO_TYPE, true] call BIS_fnc_crewCount;
[format["Helo's seat %1", _heloSeatCount]] execVM PT_DEBUG_SQF;

//See how many helo's we'd need at the start;

//TODO: CHANGE BACK
_desiredHeloCount = 2;//ceil (_playerCount / _heloSeatCount);

[format["Num required helo's %1", _desiredHeloCount]] execVM PT_DEBUG_SQF;

//Creating a copy of the array so we can perform local-only changes
_spawnLocations = +PT_HELO_SPAWN_POINTS;

for [{private _i = 0}, {_i < _desiredHeloCount}, {_i = _i + 1}] do {

	//Grab one of the spawns
	_spawnPoint = selectRandom _spawnLocations;

	//Remove used spawn from the list so we don't spawn in the same spots
	_spawnLocations = _spawnLocations - [_spawnPoint];

	_pos = _spawnPoint select 0;
	_helo = PT_TRANSIT_HELO_TYPE createVehicle _pos;

	//TODO: Add a trigger for the helo to associate it with victory/loss conditions?

	_rot = _spawnPoint select 1;
	_helo setDir _rot;

	[format["Helo %1 - Init", _helo]] execVM PT_DEBUG_SQF;
	[_helo] execVM PT_HELO_INIT_DAMAGE;

	[format["Helo %1 - Calling Trigger", _helo]] execVM PT_DEBUG_SQF;
	[_helo] execVM PT_HELO_CREATE_TRIGGER;
};

//TODO: Running into async issues - the set up scripts could be made a function and called through the 'call' implementation
// to insure they are finished before continuing
//https://community.bistudio.com/wiki/Arma_3:_Functions_Library#Function_Declaration

//TODO: Helos are created, now we create our trigger that will be conditional on all the helo leave area triggers to be activated
_heloEscapeTriggers = missionNamespace getVariable PT_HELO_TRIGGERS_VARNAME;

//Figure out how we can grab multiple triggers and add each of them having triggered onto a newly created trigger
_combinedTrigger = createTrigger ["EmptyDetector", /*Don't care about position*/PT_HELO_POS_1];

//Grab the triggerNames from the trigger mission variable
_triggersActivated = [];
_test = "";

_triggerCount = count _heloEscapeTriggers;

private _haveMultipleTriggers = _triggerCount > 1;

[format["Helo Initializing - Multiple Triggers? %1", _haveMultipleTriggers]] execVM PT_DEBUG_SQF;

//For each of the spawned helo triggers, add that trigger as a variable on the created combined trigger
// so the activation of all the triggers can be used as the final activation for the mission end/spawn end check
{
	private _selectedTrigger = _heloEscapeTriggers select _forEachIndex;

	private _triggerName = triggerText _selectedTrigger;

	_triggerVarName = "heloLeaveTrigger" + _forEachIndex;

	_combinedTrigger setvariable [_triggerVarName, _selectedTrigger];

	_triggersActivated append [_triggerVarName];

	//TODO: Figure out best way to get the '&&' between trigger activated clauses
	//Mod 2 might be the usage
	_test = test + "triggerActivated" + "getvariable " + _triggerVarName;
	//Have a boolean for if we have multiple entries, and if true, look at add '&&' between entries
} forEach _heloEscapeTriggers;

_combinedTrigger setTriggerStatements [
	/* Condition */ triggerActivated (_heloEscapeTriggers select 0),
	/* Activated Statement */
	"[format[""Helo Combined Trigger - Trigger %1 Activated"", (_heloEscapeTriggers select 0)]] execVM PT_DEBUG_SQF",
	/* Deactivated Statement */
	""];
/*
_trg settriggerstatement ["(thistrigger getvariable 'myvar' ) distance thistrigger", "",""];

_trg setvariable ['myvar', chopper1];
*/