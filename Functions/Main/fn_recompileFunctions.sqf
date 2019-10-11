/*
	ds_fnc_recompileFunctions


	a: reyhard
*/


// type in configs you would like to diag_merge
private _input		= call ds_fnc_getDebugFile;
private _functions	= _input # 1;

if(_functions isEqualTo [])then{hintC "missing debug file!";_config = []}else
{
	// recompile functions
	{
		[_x] call BIS_fnc_recompile;
	}foreach _functions;
};

if(is3DEN)then
{
	[format["Following functions were recompiled: %1",_functions],0] call bis_fnc_3DENNotification;
};

_functions