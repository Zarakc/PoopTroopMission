#include "launcherConstants.sqf";

//Called from fn_commanderFireOrder.sqf
params["_targetPos"];

["Add Coordinate Variance - Called"] call messyEvac_fnc_debugLog;

//TODO: Add minimum variance to ensure safe space?
_xRand = random ME_LAUNCHER_COORDINATE_VARIANCE + (_tarPos select 0);
_yRand = random ME_LAUNCHER_COORDINATE_VARIANCE + (_tarPos select 1);
_adjustedPos = [_xRand, _yRand, _targetPos select 2];

//[format["Add Coordinate Variance - Target Pos: %1", _targetPos]] call messyEvac_fnc_debugLog;
//[format["Add Coordinate Variance - Adjust Pos: %1", _adjustedPos]] call messyEvac_fnc_debugLog;

_adjustedPos;