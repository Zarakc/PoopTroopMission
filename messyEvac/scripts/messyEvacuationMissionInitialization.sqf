#include "..\messyEvacuationConstants.sqf";

_players = allPlayers - entities "HeadlessClient_F";

_playerCount = count _players;

[format["Mission Init - Setting player count - %1", _playerCount]] execVM ME_DEBUG_SQF;

missionNamespace setVariable ["playerCount", _playerCount];

missionNamespace setVariable ["respawnEnabled", true];

[_playerCount] execVM ME_HELO_SETUP;
[_playerCount] execVM ME_TRUCK_SETUP;
execVM ME_POD_REINFORCEMENTS_ACE_EVENT;
//Create the reinforcement launcher groupings
[] call messyEvac_fnc_createLauncherGroupings;

//execVM ME_INIATIE_REINFORCEMENTS;