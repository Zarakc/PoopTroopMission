params["_players"];

["Present Cereal Called"] call messyEvac_fnc_debugLog;

{
	_test = _x addAction ["Eat <t color='#FF0000'>Splode-E-O's</t>!", {execVM "messyEvac\functions\eatCereal.sqf"}, [_x]];

	[format["Looking for Params of Id %1", _test]] call messyEvac_fnc_debugLog;

	_paramsFound = _x actionParams _test;

	[format["Params found: %1", _paramsFound]] call messyEvac_fnc_debugLog;
} forEach _players;

//TODO: Figure out how to send player into the trigger