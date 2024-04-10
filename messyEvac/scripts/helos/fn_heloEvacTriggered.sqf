#include "heloConstants.sqf";

//Called when all the spawned helo's have left the airfield by being destroyed or flying out

[format["Helo Evac - Called", str (count _heloEscapeTriggers)]] call messyEvac_fnc_debugLog;

systemChat "Helo's have left the airfield, any stragglers are left to their fates.";

//Looking to disable the respawn mechanic
missionNamespace setVariable ["respawnEnabled", false];
[{true}, 999, "Last lives happened."] call BIS_fnc_setRespawnDelay;
//["ace_spectatorSet", ""] call CBA_fnc_remoteEvent;
//^ Did not seem to remove the event that was set up from being called