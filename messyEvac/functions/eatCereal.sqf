//params["_target", "_caller", "_actionId", "_arguments"];

[format["This: %1", _this]] call messyEvac_fnc_debugLog;
_player = _this select 0;

[format["Eat Cereal Called for %1", _player]] call messyEvac_fnc_debugLog;

// sleep 1;
// _player setHit ["hitneck", 0.8];

// sleep 1;
// _player setHit ["hitabdomen", 0.8];

sleep 4;

//"hitface","hitneck","hithead","hitpelvis","hitabdomen","hitdiaphragm","hitchest","hitbody","hitarms","hithands",
//"hitlegs","incapacitated","hitleftarm","hitrightarm","hitleftleg","hitrightleg","ace_hdbracket"]

//,["face_hub","neck","head","pelvis","spine1","spine2","spine3","body","arms","hands","legs","body","hand_l","hand_r","leg_l","leg_r","head"]
