/*
 * this function is called from each of the 3den attributes and serves
 * two purposes:
 *
 * - when in 3DEN, set goggles/insignia/face directly on the unit, so the user
 *   has instant feedback for the change
 *
 * - when actually starting up a mission, set+broadcast the attrs as variables
 */

params ["_unit", "_varname", "_value"];

if (!is3DEN) exitWith {
    _unit setVariable [_varname, _value, true];
};

/* 3DEN-only below */

switch (_varname) do {
    case "a3aa_ee_extended_gear_goggles": {
        if (_value == "None") then {
            removeGoggles _unit;
        } else {
            _unit linkItem _value;
        };
    };
    case "a3aa_ee_extended_gear_insignia": {
        /* some races when loading mission? */
        0 = [_unit, _value] spawn {
            uiSleep 0.5;
            _this call a3aa_ee_extended_gear_fnc_setUnitInsignia;
        };
    };
    case "a3aa_ee_extended_gear_face": {
        _unit setFace _value;
    };
};
