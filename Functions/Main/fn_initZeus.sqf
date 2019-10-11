/*


*/

if(profileNamespace getVariable ["DS_Var_AddZeus",true])then
{
	DS_Player = player;
	DS_curator = (createGroup sideLogic) createUnit ["ModuleCurator_F", [0,0,0], [], 0, "NONE"];
	DS_curator setVariable ["showNotification", false, true];
	DS_curator setVariable ["birdType", "", true];
	DS_curator setVariable ["Owner", "DS_player", true];
	DS_curator setVariable ["Addons", 3, true];
	DS_curator setVariable ["Forced", 0, true];
	DS_curator addEventHandler [
	'CuratorObjectRegistered',
		{
			true spawn
			{
				waitUntil {(!isNull (findDisplay 312))};
				systemChat "curator EH added";
				(findDisplay 312) displayAddEventHandler ["keyUp",{
					_handle = _this call ds_fnc_handleKey;
				}];
			};
		}
	];
};