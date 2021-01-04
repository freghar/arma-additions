/*
 * return true if a classname is a child of another classname,
 * similar to the isKindOf command for objects
 *
 * _reference can be an array
 */

params ["_class", "_reference"];

private _order = ["CfgMagazines", "CfgWeapons", "CfgAmmo", "CfgVehicles"];

private _cfg = configNull;
{
    _cfg = configFile >> _x >> _class;
    if (isClass _cfg) exitWith {};
} forEach _order;
if (!isClass _cfg) exitWith { false };

if (_reference isEqualType "") then {
    _reference = [_reference];
};

private _parents = [_cfg, true] call BIS_fnc_returnParents;

(_reference arrayIntersect _parents) isNotEqualTo [];
