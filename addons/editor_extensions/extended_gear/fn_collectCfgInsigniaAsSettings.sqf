/*
 * return two arrays suitable for CBA_settings_fnc_init's LIST
 */

private _cfgs = "true" configClasses (configFile >> "CfgUnitInsignia");

private _mission_cfg = missionConfigFile >> "CfgUnitInsignia";
if (isClass _mission_cfg) then {
    _cfgs append ("true" configClasses _mission_cfg);
};

private _classes = [""];
private _names = ["None"];
{
    _classes pushBack (configName _x);
    _names pushBack (getText (_x >> "displayName"));
} forEach _cfgs;

[_classes, _names];
