#include "..\..\messyEvacuationConstants.sqf";
#include "heloConstants.sqf";

params ["_helo"];

[format["Helo %1 - Damage Init", _helo]] execVM PT_DEBUG_SQF;
//Could do a mix of needing repair and refueling

//Damage each of the specified helo parts
{
	_part = PT_HELO_DMG_PARTS select _forEachIndex;

	[format["Helo %1 - Damaging %2 to %3", _helo, _part, PT_HELO_DMG_AMOUNT]] execVM PT_DEBUG_SQF;

	_helo setHitPointDamage [PT_HELO_DMG_PARTS select _forEachIndex, PT_HELO_DMG_AMOUNT];
} forEach PT_HELO_DMG_PARTS;

[format["Helo %1 - Removing fuel", _helo]] execVM PT_DEBUG_SQF;
_helo setFuel 0.01;