sleep 0.1;
ctrlSetText [1400,profileNamespace getVariable ["ds_debugingPath",""]];
private _path = "";

while { dialog } do
{
	_path = ctrlText 1400;
};

profileNamespace setVariable ["ds_debugingPath",_path];
saveProfileNamespace;