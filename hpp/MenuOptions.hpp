class RscShortcutButton;

class DS_Options_Button: RscShortcutButton
{
	default = 0;
	idc = -1;
	type = 16;
	style = "0x02 + 0xC0";

	text = "Debuging Options";
	action = "(findDisplay 49) closeDisplay 0; 0 spawn {_n=  createDialog 'DS_Options_Menu';0 spawn ds_fnc_debugingMenuInit;};";

	class ShortcutPos
	{
		left = 0;
		top = 0;
		w = 0;
		h = 0;
	};
	class TextPos
	{
		left = 0.01;
		top = 0;
		right = 0;
		bottom = 0;
	};

	animTextureDefault = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureDisabled = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureNormal = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureOver = "#(argb,8,8,3)color(1,1,1,1)";
	animTexturePressed = "#(argb,8,8,3)color(1,1,1,1)";

	color2[] = {0,0,0,1};
	color[] = {1,1,1,1};
	colorBackground[] = { "(profilenamespace getvariable ['GUI_BCG_RGB_R',1])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.647])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.5])" };
	colorBackground2[] = { "(profilenamespace getvariable ['GUI_BCG_RGB_R',1])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.647])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.5])" };
	colorBackgroundFocused[] = {1, 1, 1, 0};
	colorDisabled[] = {1,1,1,0.25};
	colorFocused[] = {0,0,0,1};
	colorText[] = {1,1,1,1};

	period = 1.2;
	periodFocus = 1.2;
	periodOver = 1.2;

	tooltip = "Configure debuging suite parameters";
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
	tooltipColorText[] = {1,1,1,1};

	x = "1 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX)";
	y = "-2.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + 	(safezoneY + safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))";
	w = "15 * (((safezoneW / safezoneH) min 1.2) / 40)";
	h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
};


class RscDisplayMPInterrupt: RscStandardDisplay
{
	class controls
	{
		class DS_Options : DS_Options_Button {};
	};
};
class RscDisplayInterrupt: RscStandardDisplay
{
	class controls
	{
		class DS_Options : DS_Options_Button {};
	};
};
class RscDisplayInterruptEditor3D: RscStandardDisplay
{
	class controls
	{
		class DS_Options : DS_Options_Button {};
	};
};
class RscDisplayInterruptEditorPreview: RscStandardDisplay
{
	class controls
	{
		class DS_Options : DS_Options_Button {};
	};
};

class RscCheckbox;

/*
configfile >> "RHS_Options_Menu"
*/


class DS_Options_Menu
{
	enableSimulation = true;
	idd = 101;
	movingenable = false;
	onDestroy = "systemChat 'test'";
	class Controls
	{
		class Backgrounnd: IGUIBack
		{
			idc = 2200;

			x = 0.269896 * safezoneW + safezoneX;
			y = 0.2274 * safezoneH + safezoneY;
			w = 0.474896 * safezoneW;
			h = 0.5546 * safezoneH;
		};
		class TextTop: RscStructuredText
		{
			idc = 1100;

			text = "Debuging options"; //--- ToDo: Localize;
			x = 0.465729 * safezoneW + safezoneX;
			y = 0.2368 * safezoneH + safezoneY;
			w = 0.0685417 * safezoneW;
			h = 0.0188 * safezoneH;
			colorBackground[] = {-1,-1,-1,0};
		};
		class RscEdit_1400: RscEdit
		{
			idc = 1400;

			x = 0.284583 * safezoneW + safezoneX;
			y = 0.3026 * safezoneH + safezoneY;
			w = 0.337812 * safezoneW;
			h = 0.0282 * safezoneH;
			canModify = 1;
			autocomplete = false;
			text = "test 44";
		};
		class RscStructuredText_1101: RscStructuredText
		{
			idc = 1101;

			text = "Path to debuging file"; //--- ToDo: Localize;
			x = 0.284583 * safezoneW + safezoneX;
			y = 0.2744 * safezoneH + safezoneY;
			w = 0.0930208 * safezoneW;
			h = 0.0188 * safezoneH;
			colorBackground[] = {-1,-1,-1,0};
		};
	};
};