#include "..\poopTroopConstants.sqf";

params ["_pooPod", "_poopGroup", "_launchVehicle"];

// _pooPod = _this select 0;
// _poopGroup = _this select 1;
// _launchVehicle = _this select 2;

diag_log format["PoopTroopSpawn - %1 creating unit for %2", _launchVehicle, _poopGroup];

_unit = _poopGroup createUnit [PT_UNIT_TYPE, [0,0,0], [], 0, "FORM"];
_unit allowDamage false;
_unit setPosATL getPosATL _pooPod;
_unit attachTo [_pooPod, [0,0.8,-1]];
_unit setDir 180;

diag_log "PoopTroopSpawn - Spawning Unit Code End";

//Open pod and allow unit to be injured
diag_log ["PoopTroopSpawn - Opening: ", _pooPod];

//TODO: Maybe have the pod on the ground for a second/enough time to loop before opening?
//Open the pod door
_pooPod animate ["door_1_rot", 1];

sleep 1;

deleteVehicle _pooPod;
//TODO: Disable damage before hitting the ground or solve the spiraling pod ground slam issue all over.
_unit allowDamage true;

diag_log "PoopTroopSpawn - Code End";