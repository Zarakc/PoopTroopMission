#include "..\..\messyEvacuationConstants.sqf";
#include "heloConstants.sqf";

params ["_playerCount"];

[format["Helo - Player count %1", _playerCount]] execVM PT_DEBUG_SQF;

_heloSeatCount = [PT_TRANSIT_HELO_TYPE, true] call BIS_fnc_crewCount;
[format["Helo's seat %1", _heloSeatCount]] execVM PT_DEBUG_SQF;

//See how many helo's we'd need at the start;
_desiredHeloCount = ceil (_playerCount / _heloSeatCount);
[format["Num required helo's %1", _desiredHeloCount]] execVM PT_DEBUG_SQF;

//Creating a copy of the array so we can perform local-only changes
_spawnLocations = +PT_HELO_SPAWN_POINTS;

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


