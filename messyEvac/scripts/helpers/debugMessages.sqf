#include "..\..\messyEvacuationConstants.sqf";

params["_text"];

if (ME_DEBUG_MODE isEqualTo "SERVER") then {
	diag_log format["%1%2", ME_DEBUG_HEADER, _text];
} else {
	if (ME_DEBUG_MODE isEqualTo "LOCAL") then {
		diag_log format["%1%2", ME_DEBUG_HEADER, _text];
		systemChat format["%1%2", ME_DEBUG_HEADER, _text];
	} else {
		//No logging otherwise
	};
};