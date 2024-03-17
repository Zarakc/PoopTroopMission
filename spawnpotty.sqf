params ["_pos"];

_group = createGroup west;
_unit = _group createUnit ["B_Soldier_A_F", _pos, [], 0, "FORM"];

_pod = "Land_ToiletBox_F" createVehicle _pos;

[_unit,"SIT","ASIS"] call BIS_fnc_ambientAnim;

_unit attachTo [_pod, [0,0.7,-0.5]];
_unit setDir 180;
_unit attachTo [_pod, [0,0.7,-0.5]];