#include "..\..\messyEvacuationConstants.sqf";
#include "heloConstants.sqf";

params ["_helo"];

[format["Helo %1 - Damage Init", _helo]] execVM PT_DEBUG_SQF;
//Could do a mix of needing repair and refueling

//["part(s)ToDamage", dmgAmount]
_dmgScenario = selectRandom PT_HELO_DISABLED_SCENARIOS;

[format["Helo %1 - Damage Scenario: %2", _helo, _dmgScenario]] execVM PT_DEBUG_SQF;

_parts = _dmgScenario select 0;
_dmgAmount = _dmgScenario select 1;

//Damage each of the specified helo parts
{
	_part = _parts select _forEachIndex;

	[format["Helo %1 - Damaging %2 to %3", _helo, _part, _dmgAmount]] execVM PT_DEBUG_SQF;

	_helo setHitPointDamage [_part, _dmgAmount];
} forEach _parts;

// [format["Helo %1 - Removing fuel", _helo]] execVM PT_DEBUG_SQF;
// _helo setFuel 0.01;