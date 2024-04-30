#include "launcherConstants.sqf";

//Called by orderLauncherToReinforce.sqf
//Trigger that we enable' by changing the condition statement back to its working state
params["_trigger"];

//Set the trigger interval to allow for time between waves
_trigger setTriggerInterval ME_LAUNCHER_TRIGGER_INTERVAL;

_triggerStatements = triggerStatements _trigger;

//'Renable' the trigger by setting the condition back to its original value
_trigger setTriggerStatements [ME_LAUNCHER_REINFORCE_CONDITION, _triggerStatements select 1, _triggerStatements select 2];

//[_trigger, "Enable Reinforce Trigger", "Reactivation"] call messyEvac_fnc_outputTriggerStatements;