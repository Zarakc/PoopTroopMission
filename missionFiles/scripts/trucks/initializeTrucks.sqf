#include "..\..\messyEvacuationConstants.sqf";
#include "truckConstants.sqf";

_truck = PT_FUEL_VEHICLE_TYPE createVehicle PT_FUEL_POS_1;
_truck setDir PT_FUEL_ROT_1;

[format["Truck %1 - Init", _truck]] execVM PT_DEBUG_SQF;

[_truck] execVM PT_TRUCK_INIT_DAMAGE;