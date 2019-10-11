//#include "\A3\basicDefines_A3.hpp"
#include "cfgPatches.hpp"

class RscListBox;
class RscListNBox;
class RscButtonMenuOK;
class RscButtonMenuCancel;
class RscText;
class RscPicture;
class RscActiveText;
class RscCombo;
class RscProgress;
class RscButton;
class RscButtonMenu;
class RscObject;
class RscStandardDisplay;
class RscStructuredText;
class RscControlsGroupNoScrollbars;
class RscHTML;
class RscEdit;
class RscTitle;
class RscVignette;
class RscFrame;
class RscControlsGroupNoHScrollbars;
class RscControlsGroup;
class RscIGProgress;
class RscHitZones;
class RscIGUIValue;
class RscIGUIText;
class RscPictureKeepAspect;
class RscUnitInfo;
class VScrollbar;
class HScrollbar;
class RscOpticsValue;
class RscOpticsText;
class RscLadderPicture;
class Attributes;
class RscDisplayGetReady;
class IGUIBack;
class CA_Title;
class ScrollBar;

#include "cfgFunctions.hpp"
#include "hpp\MenuOptions.hpp"
#include "dikCodes.hpp"

class ctrlMenuStrip;
class Display3DEN
{
	class Controls
	{
		class MenuStrip: ctrlMenuStrip
		{
			class Items
			{
				class Tools
				{
					items[] += {"DS_Debug"};
				};
				class DS_Debug
				{
					text = "Debug Tools";
					items[] = {
						"DS_Debug_MergeConfig",
						"DS_Debug_ResetShapes",
						"DS_Debug_RecompileFunctions"
					};
				};

				class DS_Debug_MergeConfig
				{
					text = "Merge config files";
					shortcuts[] = {INPUT_CTRL_OFFSET + DIK_1};
					action = "[] call ds_fnc_mergeConfig;";
				};
				class DS_Debug_ResetShapes
				{
					text = "Reset shapes";
					shortcuts[] = {INPUT_CTRL_OFFSET + DIK_2};
					action = "['Reset shapes activated',0] call bis_fnc_3DENNotification;diag_resetshapes;";
				};
				class DS_Debug_RecompileFunctions
				{
					text = "Recompile functions";
					shortcuts[] = {INPUT_CTRL_OFFSET + DIK_5};
					action = "[] call ds_fnc_recompileFunctions;";
				};
			};
		};
	};
};