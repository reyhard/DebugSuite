class CfgFunctions
{
	// debug suite
	class DS
	{
		version = 1.0;
		class Main
		{
			recompile	= 1;
			file = "Pomarancz\addons\DebugSuite\Functions\Main";
			class Init
			{
				description	= "Initializes debuging suite hotkeys";
				postInit	= 1;
				recompile	= 1;
				headerType 	= -1;
			};
			class InitZeus
			{
				description	= "Initializes debuging suite zeus interface";
				preInit		= 1;
				recompile	= 1;
				headerType	= -1;
			};
			class HandleKey
			{
				description	= "Handles key strokes";
				recompile	= 1;
				headerType 	= -1;
			};
			class parseCode
			{
				description	= "Parse code & remove i.e. comments from debug file";
			};
			class getDebugFile
			{
				description	= "Get debug file";
			};
			class mergeConfig
			{
				description	= "Merge config listed in debug file";
			};
			class recompileFunctions
			{
				description	= "Recompile all functions listed in debug file";
			};
		};
		class Menu
		{
			file = "Pomarancz\addons\DebugSuite\Functions\Menu";
			class debugingMenuInit
			{
				description	= "Handles key strokes";
				recompile	= 1;
				headerType 	= -1;
			};
		};
	};
};