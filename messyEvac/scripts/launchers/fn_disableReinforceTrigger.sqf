#include "launcherConstants.sqf";

//Called by orderLauncherToReinforce.sqf
//Trigger that we disable by changing the condition statement to 'false' so it cannot be active
params["_trigger"];

_triggerStatements = triggerStatements _trigger;

_trigger setTriggerStatements ["false", _triggerStatements select 1, ""];

//[_trigger, "Disable Reinforce Trigger", "Deactivation"] call messyEvac_fnc_outputTriggerStatements;