/*
 * a better, sane, respawn and JIP-proof variant of BIS_fnc_setUnitInsignia
 */

#define DEFAULT_MATERIAL "\a3\data_f\default.rvmat"
#define DEFAULT_TEXTURE "#(rgb,8,8,3)color(0,0,0,0)"

params ["_unit", "_insignia"];

private _cfg = missionConfigFile >> "CfgUnitInsignia" >> _insignia;
if (!isClass _cfg) then {
    _cfg = campaignConfigFile >> "CfgUnitInsignia" >> _insignia;
    if (!isClass _cfg) then {
        _cfg = configFile >> "CfgUnitInsignia" >> _insignia;
    };
};

/* don't remove insignia if invalid classname was given */
if (!isClass _cfg && _insignia != "") exitWith { false };

private _mat = getText (_cfg >> "material");
if (_mat == "") then {
    _mat = DEFAULT_MATERIAL;
};

private _texture = getText (_cfg >> "texture");
if (_texture == "") then {
    _texture = DEFAULT_TEXTURE;
};

private _uniform = uniform _unit;
if (_uniform == "") exitWith { false };

private _uniform_soldier = getText (
    configFile >> "CfgWeapons" >> _uniform >> "ItemInfo" >> "uniformClass"
);
if (_uniform_soldier == "") exitWith { false };

private _selections = getArray (
    configFile >> "CfgVehicles" >> _uniform_soldier >> "hiddenSelections"
);

private _idx = _selections find "insignia";
if (_idx == -1) exitWith { false };

_unit setObjectMaterialGlobal [_idx, _mat];
_unit setObjectTextureGlobal [_idx, _texture];

if (isClass _cfg) then {
    _unit setVariable ["BIS_fnc_setUnitInsignia_class", _insignia, true];
} else {
    _unit setVariable ["BIS_fnc_setUnitInsignia_class", nil, true];
};

true;
