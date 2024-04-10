spectatorEventHandler = {
	params ["_isSpectator", "_player"];
	
	diag_log "Spectator Handler - Called";
	systemChat "Spectator Handler - Called";

	if (!_isSpectator) then {

		_respawnEnabled = missionNamespace getVariable "respawnEnabled";

		[diag_log format["Spectator Handler - Respawn Enabled: %1", _respawnEnabled]];
		[systemChat format["Spectator Handler - Respawn Enabled: %1", _respawnEnabled]];

		if (_respawnEnabled isEqualTo true) then {
			diag_log "Spectator Handler - Respawning %1", _respawnEnabled;
			systemChat "Spectator Handler - Respawning %1", _respawnEnabled;

			[_player] call BDRM_fnc_respawnPlayer;
		} else {
			diag_log "Helo Evac - Respawning Disabled";
			systemChat "Helo Evac - Respawning Disabled";
			//TODO: This ends up respawning the player at their death and just not the marked respawn
		};
	}
};

["ace_spectatorSet", spectatorEventHandler] call CBA_fnc_addEventHandler;
