#include "..\..\messyEvacuationConstants.sqf";
#include "..\..\..\bdrm\constants.sqf"
//From a trigger in Novy Sobor that detects the presence of players

//If the unit is null, grab the cargoIndex to use for moveInCargo;

//Grab each person in the zone and then throw them into unoccupied seats in their corresponding respawn vehicle

//Split up the players into their groups
//Go through for each empty seat and spawn a player there (likely exclude the driver seat)
//Overflow will be treated on the next trigger(hopefully)
params ["_players", "_trigger"];

_eastSectionMembers = [];
_southSectionMembers = [];

[format ["Stranded Respawn - Players: %1", _players]] call messyEvac_fnc_debugLog;

{
	//Get the group name for the player to know which respawn vehicle they go to
	_group = group _x;
	_playerGroupName = groupId _group;
	//[format ["Stranded Respawn - Player Groupname: %1", _playerGroupName]] call BDRM_fnc_diag_log;

	_isEast = [BDRM_EAST_GROUP_MARKER, _playerGroupName] call BIS_fnc_inString;
	if(_isEast) then {
		_eastSectionMembers pushBack _x;
	} else {
		_southSectionMembers pushBack _x;
	};

} forEach _players;

[format ["Stranded Respawn - East Players: %1", _eastSectionMembers]] call messyEvac_fnc_debugLog;
[format ["Stranded Respawn - South Players: %1", _southSectionMembers]] call messyEvac_fnc_debugLog;

_eastRespawnMarkerName = getText(getMissionConfig "BDRMConfig" >> BDRM_EAST_VEHICLE_MARKER_NAME);
_southRespawnMarkerName = getText(getMissionConfig "BDRMConfig" >> BDRM_SOUTH_VEHICLE_MARKER_NAME);

//Used for tracking number of unstranded players to see if we have excess at the end
_unstrandedPlayers = [];

{
	[format ["Stranded Respawn - Index: %1", _x]] call messyEvac_fnc_debugLog;

	_strandedFolk = [];
	_respawnMarkerName = "";

	if(_x == 0) then {
		_strandedFolk = _eastSectionMembers;
		_respawnMarkerName = _eastRespawnMarkerName;
	} else {
		_strandedFolk = _southSectionMembers;
		_respawnMarkerName = _southRespawnMarkerName;
	};

	[format ["Stranded Respawn - Stranded Folk: %1", _strandedFolk]] call messyEvac_fnc_debugLog;
	[format ["Stranded Respawn - Vehicle Name: %1", _respawnMarkerName]] call messyEvac_fnc_debugLog;

	_curSectionCount = count _strandedFolk;
	_zeroIndexedSectionCount = _curSectionCount -1;

	if(_zeroIndexedSectionCount >= 0) then {

		//[format ["Stranded Respawn - Respawn Vehicle Name %1", _respawnMarkerName]] execVM ME_DEBUG_SQF;

		_respawnVehicle = missionNamespace getVariable _respawnMarkerName;
		//[format ["Stranded Respawn - Respawn Vehicle %1", _respawnVehicle]] execVM ME_DEBUG_SQF;

		//Jeeps use the turrets as the passenger seats
		_turretSeatsSytnax = fullCrew [_respawnVehicle, "turret", true];

		//==================================
		//Get only empty turret seats for the vehicle
		_freeTurretSeats = [];

			//private _actionCompatibleCargoIndexes = fullCrew [heli, "cargo", true];
			//[unit, role, cargoIndex, turretPath, personTurret, assignedUnit, positionName]: 
			//[<NULL-object>,""turret"",0,[2],true,<NULL-object>,""Passenger (Front Right Seat)""]
			//_strandedPlayer moveInTurret 

		//[Vehicle, Seat Type, includeEmpty]
		_vehicleTurretSeats = fullCrew [_respawnVehicle, "turret", true];
		//Returns [unit, role, cargoIndex, turretPath, personTurret, assignedUnit, positionName]:
		//We care about unit and turretPath if unit is not null/null obj

		{
			_seat = _x;
			_unitInSeat = _seat select 0;
			[format ["Stranded Respawn - %1's Turrets Unit %2: %3", _respawnVehicle, _forEachIndex, _unitInSeat]] call messyEvac_fnc_debugLog;

			if(isNull _unitInSeat) then {//TODO: See if this works how we expect
				_turretSeat = _seat select 3;
				[format ["Stranded Respawn - %1's Turret %2: %3", _respawnVehicle, _forEachIndex, _turretSeat]] call messyEvac_fnc_debugLog;
				_freeTurretSeats pushBack _turretSeat;
			};
		} forEach _vehicleTurretSeats;

		[format ["Stranded Respawn - %1's Free Turret Seats: %2", _respawnVehicle, _freeTurretSeats]] call messyEvac_fnc_debugLog;

		//If there are no free seats, we should break out of this forEach
		if(count _freeTurretSeats == 0) then {
			["Stranded Respawn - No Free Seats"] call messyEvac_fnc_debugLog;
			break;
		};

		//==================================

		//Turret syntax instead of crewSeat syntax
		_vehicleTurretSeats = allTurrets [_respawnVehicle, true];
		[format ["Stranded Respawn - %1's Turrets: %2", _respawnVehicle, _vehicleTurretSeats]] call messyEvac_fnc_debugLog;

		//[format ["Stranded Respawn - %1's Seats Array: %2", _respawnVehicle, _turretSeatsSytnax]] execVM ME_DEBUG_SQF;
		{
			//[format["Stranded Respawn - %1's Seats: %2", _respawnVehicle, _x]] execVM ME_DEBUG_SQF;
			if(_forEachIndex <= _zeroIndexedSectionCount) then {

				_strandedPlayer = _strandedFolk select _forEachIndex;
				[format["Stranded Respawn - Stranded Player: %1", _strandedPlayer]] call messyEvac_fnc_debugLog;

					//moveInTurret is complaining about wanting a number despite documentation saying its given the turret
				_freeTurretArray = _x;

				//TODO: Need to do an open seat comparison, otherwise we run into issues with assumptions of seating

				//_freeTurretSeat = _x select 0;
				[format["Stranded Respawn - Respawn Vehicle: %1", _respawnVehicle]] call messyEvac_fnc_debugLog;
				[format["Stranded Respawn - Free Turret Array: %1", _freeTurretArray]] call messyEvac_fnc_debugLog;

				//It got an object, wanted an array
				_strandedPlayer moveInTurret[_respawnVehicle, _freeTurretArray];

				//Remove our unstranded player from our array
				_strandedPlayerName = [_strandedPlayer] call BIS_fnc_getName;
				_unstrandedPlayers pushBack _strandedPlayerName;
				[format["Stranded Respawn - Unstranded Folk: %1", _unstrandedPlayers]] call messyEvac_fnc_debugLog;
			} else {
				[format["Stranded Respawn - More Seats(%1) than stranded players(%2)", _forEachIndex, _curSectionCount]] call messyEvac_fnc_debugLog;
			};

		} forEach _freeTurretSeats;

	} else {
		[format["Stranded Respawn - No Stranded Folk for %1", _respawnMarkerName]] call messyEvac_fnc_debugLog;
	};
} forEach [0, 1];

_countSaved = count _unstrandedPlayers;

[format["Stranded Respawn - Saved Folk Count: %1", count _unstrandedPlayers]] call messyEvac_fnc_debugLog;
[format["Stranded Respawn - Player Count: %1", count _players]] call messyEvac_fnc_debugLog;

if(_countSaved < count _players) then {
	//TODO:If there are leftover players - inform them
};

//Change to something else to deactivate - the On Deactivate code will change itself back
_trigger setTriggerActivation ["GUER", "PRESENT", true];
