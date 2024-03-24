#include "..\..\messyEvacuationConstants.sqf";
#include "heloConstants.sqf";

private _players = allPlayers - entities "HeadlessClient_F";

_playerCount = count _players;//[params] call fnc_name; PT_PLAYER_COUNT_SQF;
[format["Player count %1", _playerCount]] execVM PT_DEBUG_SQF;


_heloSeatCount = [PT_TRANSIT_HELO_TYPE, true] call BIS_fnc_crewCount;
[format["Helo's seat %1", _heloSeatCount]] execVM PT_DEBUG_SQF;

//See how many helo's we'd need at the start;
_desiredHeloCount = ceil (_playerCount / _heloSeatCount);
[format["Num required helo's %1", _desiredHeloCount]] execVM PT_DEBUG_SQF;
//playerCount mod helo capacity;
//We want to randomize the spawns to always have at least two helo's
//{
	_spawnPoint = selectRandom PT_HELO_SPAWN_POINTS;/* select _forEachIndex*/
	//Remove our currently selected spawnPoint from future runs
	//PT_HELO_SPAWN_POINTS = PT_HELO_SPAWN_POINTS - _spawnPoint;

	_pos = _spawnPoint select 0;
	_helo = PT_TRANSIT_HELO_TYPE createVehicle _pos;

	_rot = _spawnPoint select 1;
	_helo setDir _rot;

	[format["Helo %1 - Init", _helo]] execVM PT_DEBUG_SQF;
	[_helo] execVM PT_HELO_INIT_DAMAGE;

// } forEach PT_HELO_SPAWN_POINTS;


