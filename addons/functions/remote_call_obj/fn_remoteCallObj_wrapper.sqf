params ["_func", "_obj", "_cond", "_unique_id"];

/* if condition matches, remove the JIP queue entry and do nothing */
if (_obj call _cond) exitWith {
    remoteExec ["", _unique_id];
};

/* unpack arg */
private ["_arg"];
if (_func isEqualType []) then {
    _arg = _func select 0;
    _func = _func select 1;
};

if (_func isEqualType "") then {
    _func = missionNamespace getVariable [_func, {}];
};

[_arg, _func] call BIS_fnc_call;
