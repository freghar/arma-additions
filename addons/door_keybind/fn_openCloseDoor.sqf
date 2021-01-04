if (isClass (configFile >> "CfgPatches" >> "ace_interaction")) exitWith {};

getCursorObjectParams params ["_obj", "_selections", "_radius"];
if (isNull _obj || _selections isEqualTo []) exitWith {};

private _house_actions = (configOf _obj >> "UserActions");
if (!isClass _house_actions) exitWith {};

_selections = _selections apply { toLower _x };

/* execute a string using a 'this' global var, return result */
private _exec_str = {
    params ["_obj", "_str"];
    private _code = compile _str;
    private ["_result", "_oldthis"];
    /* unscheduled so we get exclusive access to 'this' */
    isNil {
        _oldthis = this;
        this = _obj;
        _result = [] call _code;
        this = _oldthis;
    };
    _result;
};

{
    private _sel = getText (_x >> "actionNamedSel");
    if ((toLower _sel) in _selections) then {
        private _cond = getText (_x >> "condition");
        private _dist = getNumber (_x >> "radius");
        if (_cond != "" && _dist != 0 && _radius <= (_dist+0.5) && {[_obj, _cond] call _exec_str}) then {
            private _stmt = getText (_x >> "statement");
            if (_stmt != "") then {
                [_obj, _stmt] call _exec_str;
            };
        };
    };
} forEach ("true" configClasses (_house_actions));
