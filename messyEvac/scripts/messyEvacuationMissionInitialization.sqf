#include "..\messyEvacuationConstants.sqf";

_players = allPlayers - entities "HeadlessClient_F";

_playerCount = count _players;

[format["Setting player count - %1", _playerCount]] execVM PT_DEBUG_SQF;

missionNamespace setVariable ["playerCount", _playerCount];

missionNamespace setVariable ["respawnEnabled", true];

[_playerCount] execVM PT_HELO_SETUP;
[_playerCount] execVM PT_TRUCK_SETUP;
execVM PT_POD_REINFORCEMENTS_ACE_EVENT;