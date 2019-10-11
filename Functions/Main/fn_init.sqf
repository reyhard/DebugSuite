/*


*/
// Wait a little bit so player & UI is properly initialized
[] spawn {
sleep 0.01;

	if( (uiNamespace getVariable ["ds_keystroke",-1]) != -1)then{
		(findDisplay 46) displayRemoveEventHandler ["keyDown",uiNamespace getVariable ["ds_keystroke",-1]];
	};

	_keyHandler = (findDisplay 46) displayAddEventHandler ["keyDown",{
		_handle = _this call ds_fnc_handleKey;
	}];

	if(profileNamespace getVariable ["DS_Var_AddArsenal",true])then{player addAction ["<t color='#FD6042'>Arsenal</t>", {["Open",true] spawn BIS_fnc_arsenal}];};
	if(profileNamespace getVariable ["DS_Var_AddGarage",true])then{player addAction ["<t color='#60FD44'>VG</t>", {["Open",true] spawn BIS_fnc_garage}];};
	if(profileNamespace getVariable ["DS_Var_AddZeus",true])then
	{
		DS_Player = player;
		DS_curator = (createGroup sideLogic) createUnit ["ModuleCurator_F", [0,0,0], [], 0, "NONE"];
		DS_curator setVariable ["showNotification", false, true];
		DS_curator setVariable ["birdType", "", true];
		DS_curator setVariable ["Owner", "DS_player", true];
		DS_curator setVariable ["Addons", 3, true];
		DS_curator setVariable ["Forced", 0, true];
		{
			_x addEventHandler [
			'CuratorObjectRegistered',
				{
					true spawn
					{
						waitUntil {(!isNull (findDisplay 312))};
						systemChat "curator EH added";
						// Add all objects to list of editable entities
						{
							_x addCuratorEditableObjects [allMissionObjects "All",true];
						}foreach allCurators;
						(findDisplay 312) displayAddEventHandler ["keyDown",{
							_handle = _this call ds_fnc_handleKey;
						}];
					};
				}
			];
		}foreach allCurators;
	};

	uiNamespace setVariable ["ds_keystroke",_keyHandler];
};