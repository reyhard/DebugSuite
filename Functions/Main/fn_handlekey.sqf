/*
	ds_fnc_HandleKey
	Options:
		ctrl+1 - merges config files specified in _config array. it's possible to merge multiple configs at once. if using VG vehicle is respawned with new values
		ctrl+2 - reseting shapes ( diag_resetshapes )
		ctrl+3 - resting loadout
		ctrl+4 - reset object you are looking at
		ctrl+5 - reset functions listed

	a: reyhard, some code copy pasted from VG
*/


params ["", "_dikCode", "_shift", "_ctrlKey", "_alt"];

private _handle = false;
//systemChat format["%1",_dikCode];

if (_ctrlKey ) then {


	// config merge
	// ctr+1
	if(_dikCode isEqualTo 2)then{

		private _config		= call ds_fnc_mergeConfig;
		private _functions	= call ds_fnc_recompileFunctions;
		systemChat format["functions recompiled: %1", _functions];

		// if in vehicle, restart it
		if((! isNull objectParent player) or (! isnil "BIS_fnc_garage_center"))then
		{
			systemChat "respawning vehicle";
			[] spawn
			{
				private _vehicle = objectParent player;

				if(isNull _vehicle && !(isNil "BIS_fnc_garage_center"))then{
					_vehicle = BIS_fnc_garage_center;
				};

				private _uav = 1 isEqualTo (getNumber (configFile >> "cfgVehicles" >> typeOf _vehicle >> "isUAV"));

				_vehiclePos = position _vehicle;
				_vehicleDir = getDir _vehicle;
				_class = typeOf _vehicle;
				_engineState = isEngineOn _vehicle;
				_vehicle setVelocity [0,0,0];
				_vehiclePos set [2,0.1];
				_players = [];
				_crew = [];
				{
					if (isplayer _x) then {
						_players pushback [_x,assignedvehiclerole _x];
						moveout _x;
					} else {
						_crew pushback [_x,assignedvehiclerole _x];
						moveout _x;
					};
				} foreach crew _vehicle;

				deleteVehicle _vehicle;
				sleep 0.01;
				_vehicle = _class createVehicleLocal _vehiclePos;
				_vehicle setpos _vehiclePos;
				_vehicle setDir _vehicleDir;
				_vehicle setVelocity [0,0,0];
				if(_engineState)then{_vehicle engineOn true};

				// restart garage vehicle
				if(! isnil "BIS_fnc_garage_center")then
				{
					missionnamespace setvariable ["BIS_fnc_arsenal_center",_vehicle];
					BIS_fnc_garage_center = _vehicle;
				};
				// allow damage for testing purposes
				_vehicle allowDamage true;

				//--- Restore player seats
				{
					_player = _x select 0;
					_roleArray = _x select 1;
					_role = _roleArray select 0;
					switch (tolower _role) do {
						case "driver": {
							if (_vehicle emptypositions _role > 0) then {_player moveindriver _vehicle;} else {_player moveinany _vehicle;};
						};
						case "gunner";
						case "commander";
						case "turret": {
							if (count (allturrets _vehicle) > 0) then {_player moveinturret [_vehicle,_roleArray select 1];} else {_player moveinany _vehicle;};
						};
						case "cargo": {
							if (count _roleArray > 1)then{
								if (count (allturrets _vehicle) > 0) then {_player moveinturret [_vehicle,_roleArray select 1];} else {_player moveinany _vehicle;};
							}else{
								if (_vehicle emptypositions _role > 0) then {_player moveincargo _vehicle;} else {_player moveinany _vehicle;};
							};
						};
					};
				} foreach (_players + _crew);
				player reveal _vehicle;
				if(_uav)then
				{
					createVehicleCrew _vehicle;
					player connectTerminalToUAV _vehicle;
					player remoteControl _vehicle;
					_vehicle switchCamera "internal";
				};
				sleep 1.01;
			};
		};

		hint format["merging config:\n%1\ntime: 0+%2s",_config,time];
		_handle = true;
	};

	// model reloading
	// ctrl+2
	if(_dikCode isEqualTo 3)then{
		hint format["reseting shapes\ntime: 0+%1s",time];
		diag_resetshapes;
		_handle = true;
	};
	// loadout reload
	// ctrl+3
	if(_dikCode isEqualTo 4)then{
		hint format["reseting loadout \ntime: 0+%1s",time];
		_handle = true;
		[] spawn
		{
			private _loadout = getUnitLoadout player;
			private _currentWeapon = currentWeapon player;
			private _currentMuzzle = currentMuzzle player;
			private _currentMagazine = weaponState player select 3;

			sleep 0.01;
			player removeWeapon _currentWeapon;
			sleep 0.01;
			player setUnitLoadout [_loadout,true];
			player selectWeapon _currentMuzzle;
			player addPrimaryWeaponItem _currentMagazine;
			//player playactionnow "gestureEmpty";
		};
	};
	// reset cursor object & merge config
	// ctr+4
	if(_dikCode isEqualTo 5)then{
		// type in configs you would like to diag_merge

		_config = call ds_fnc_mergeConfig;

		systemChat "reseting cursorObject";
		_config spawn
		{

			private _vehicle = cursorObject;
			if( ! isNull (findDisplay 312))then{
				if(count curatorMouseOver isEqualTo 1)exitWith{};
				_vehicle = curatorMouseOver select 1;
			};
			if(isNull _vehicle)exitWith{};

			systemChat format["vehicle selected: %1", _vehicle];

			_players = [];
			_crew = [];
			{
				if (isplayer _x) then {
					_players pushback [_x,assignedvehiclerole _x];
					moveout _x;
				} else {
					_role = assignedvehiclerole _x;
					if(typeName _role == "STRING")then
					{
						_crew pushback [_x,assignedvehiclerole _x];
					};
					moveout _x;
					_x allowDamage false;
				};
			} foreach crew _vehicle;

			_vehiclePos = position _vehicle;
			_vehicleDir = getDir _vehicle;
			_class = typeOf _vehicle;
			deleteVehicle _vehicle;
			sleep 0.01;
			_vehicle = _class createVehicleLocal _vehiclePos;
			if(_class isKindOf "AllVehicles")then{_vehiclePos = _vehiclePos vectorAdd [0,0,0.3]};
			_vehicle setpos _vehiclePos;
			_vehicle setDir _vehicleDir;
			_vehicle setVelocity [0,0,0];

			_vehicle allowDamage false;

			//--- Restore player seats
			{
				_player = _x select 0;
				_roleArray = _x select 1;
				_role = _roleArray select 0;
				switch (tolower _role) do {
					case "driver": {
						if (_vehicle emptypositions _role > 0) then {_player moveindriver _vehicle;} else {_player moveinany _vehicle;};
					};
					case "gunner";
					case "commander";
					case "turret": {
						if (count (allturrets _vehicle) > 0) then {_player moveinturret [_vehicle,_roleArray select 1];} else {_player moveinany _vehicle;};
					};
					case "cargo": {
						if (count _roleArray > 1)then{
							if (count (allturrets _vehicle) > 0) then {_player moveinturret [_vehicle,_roleArray select 1];} else {_player moveinany _vehicle;};
						}else{
							if (_vehicle emptypositions _role > 0) then {_player moveincargo _vehicle;} else {_player moveinany _vehicle;};
						};
					};
				};
			} foreach (_players + _crew);

			if(! isnil "BIS_fnc_garage_center")then
			{
				missionnamespace setvariable ["BIS_fnc_arsenal_center",_vehicle];
				BIS_fnc_garage_center = _vehicle;
			};
			{_x addCuratorEditableObjects [[_vehicle], true]}foreach allCurators;
			_vehicle setVelocity [0,0,0];
			hint format["cursor object reset, merging config:\n%1\ntime: 0+%2s",_this,time];

			sleep 0.1;

			if(!isnull _vehicle)then{
				{(_x select 0) allowDamage true}foreach _crew;
				_vehicle allowDamage true;
				_vehicle setVelocity [0,0,0];
				_vehicle setpos _vehiclePos;
			};
		};
		_handle = true;
	};

	// recompile selected functions
	// ctr+5
	if(_dikCode isEqualTo 6)then{
		// type in configs you would like to diag_merge

		_functions = call ds_fnc_recompileFunctions;
		systemChat format["functions recompiled: %1", _functions];
		_handle = true;
	};
	if(_dikCode isEqualTo 7)then{
		systemChat format["ragdoll reloaded: %1", time];
		_handle = true;
		rd_reload "P:\a3\Data_f\physX.hpp";
	};
	if(_dikCode isEqualTo 8)then{
		systemChat format["weapon reloaded: %1", time];
		_weapon = currentWeapon player;
		player addWeapon "arifle_MX_ACO_pointer_F";
		_weapon spawn {sleep 0.1;player addWeapon _this};
		_handle = true;
	};
	if(_handle)then
	{
		disableUserInput true;
		disableUserInput false;
	};
};

_handle;