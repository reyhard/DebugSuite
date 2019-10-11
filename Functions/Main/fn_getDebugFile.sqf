/*
	ds_fnc_getDebugFile


	a: reyhard
*/

private _debugFile = format["%1",profileNamespace getVariable ["ds_debugingPath",""]];
private _input = call compile ([diag_loadTextFile _debugFile] call ds_fnc_parseCode);

if(_debugFile isEqualTo "")exitWith{[["MISSING"],[]]};

_input