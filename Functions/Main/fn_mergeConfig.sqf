/*
	ds_fnc_mergeConfig


	a: reyhard
*/

// type in configs you would like to diag_merge
private _input		= call ds_fnc_getDebugFile;
private _config		= _input # 0;

if(_config isEqualTo ["MISSING"])then{hintC "missing debug file!";_config = []}else
{
	// merge config file
	{
		_toMerge = format["%1",_x];
		_arrayLenght = count _x;
		if((_x select [_arrayLenght-10,_arrayLenght]) != "config.cpp")then
		{
			if(_x select [_arrayLenght-4,_arrayLenght] == ".hpp")then
			{
				// replace .hpp with .cpp
				_split =_x splitString "\";
				_toMerge = format["%1\config.cpp",_x select [0,_arrayLenght - 1 - (count (_split select (count _split - 1)))]];
			}else{
				_toMerge = format["%1\config.cpp",_x];
			};
		};
		_config set [_forEachIndex,_toMerge];
		if(isFilePatchingEnabled)then{diag_mergeConfigFile [_toMerge];};
	}foreach _config;
};
if(is3DEN)then
{
	[format["Following configs were merged: %1",_config],0] call bis_fnc_3DENNotification;
};
_config