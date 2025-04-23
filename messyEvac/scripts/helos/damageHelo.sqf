#include "..\..\messyEvacuationConstants.sqf";
#include "heloConstants.sqf";

params ["_helo"];

//Could do a mix of needing repair and refueling

//[[_partToDamage, _dmgAmount], [_anotherPartToDamage, _possiblyDifferentAmount]]
_dmgScenario = selectRandom ME_HELO_DISABLED_SCENARIOS;

[format["Helo Damage - %1 - Scenario: %2", _helo, _dmgScenario]] call messyEvac_fnc_debugLog;

["Helo Init Damage"] call messyEvac_fnc_helosLeft;

//For each part/dmg combo in the scenario, set that dmg for that part
{
	//[_partToDamage, _dmgAmount]
	private _part = _x select 0;
	private _dmgAmount = _x select 1;

	if(_part == "fuel") then {
		_helo setFuel _dmgAmount;
		[format["Helo %1 - Setting fuel to %2", _helo, _dmgAmount]] call messyEvac_fnc_debugLog;
	} else {
		[format["Helo %1 - Damaging %2 to %3", _helo, _part, _dmgAmount]] call messyEvac_fnc_debugLog;

		_helo setHitPointDamage [_part, _dmgAmount];
	};

} forEach _dmgScenario;
