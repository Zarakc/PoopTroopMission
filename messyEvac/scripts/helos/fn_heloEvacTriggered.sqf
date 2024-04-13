#include "heloConstants.sqf";

//Called when all the spawned helo's have left the airfield by being destroyed or flying out
[format["Helo Evac - Called", str (count _heloEscapeTriggers)]] call messyEvac_fnc_debugLog;

systemChat "Helo's have left the airfield, any stragglers are left to their fates.";