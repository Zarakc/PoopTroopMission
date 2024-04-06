#include "..\..\messyEvacuationConstants.sqf";

{
	_playerCount = missionNamespace getVariable "playerCount";

	[format["Player Count - Retrieved player count - %1", _playerCount]] execVM PT_DEBUG_SQF;

	_playerCount;
};