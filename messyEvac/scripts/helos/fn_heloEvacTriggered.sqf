#include "heloConstants.sqf";

//Called when all the spawned helo's have left the airfield by being destroyed or flying out

[format["Helo Evac - Called", str (count _heloEscapeTriggers)]] call messyEvac_fnc_debugLog;

//Looking to disable the respawn mechanic
missionNamespace setVariable ["respawnEnabled", false];
missionNamespace setVariable ["respawn", "BIRD"];
//["ace_spectatorSet", ""] call CBA_fnc_remoteEvent;
//^ Did not seem to remove the event that was set up from being called