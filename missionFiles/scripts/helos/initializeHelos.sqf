#include "..\..\messyEvacuationConstants.sqf";
#include "heloConstants.sqf";

_helo = PT_TRANSIT_HELO_TYPE createVehicle PT_HELO_POS_1;

[format["Helo %1 - Init", _helo]] execVM PT_DEBUG_SQF;

[_helo] execVM PT_HELO_INIT_DAMAGE;
