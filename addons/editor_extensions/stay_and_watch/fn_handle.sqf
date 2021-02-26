if (is3DEN) exitWith {};

params ["_unit", "_varname", "_value"];

switch (_varname) do {
    case "a3aa_ee_stay_and_watch_stay": {
        if (_value) then {
            _unit setVariable [_varname, _value, true];
        };
    };
    case "a3aa_ee_stay_and_watch_watch": {
        if (_value) then {
            _unit setVariable ["a3aa_ee_stay_and_watch_pos",
                                _unit modelToWorld [0,100000,0], true];
        };
    };
};

/* collate both attributes in one JIP queue entry */
if (!(_unit getVariable ["a3aa_ee_stay_and_watch_has_jip_re", false])) then {
    _unit setVariable ["a3aa_ee_stay_and_watch_has_jip_re", true];

    /*
     * disableAI and lookAt do actually have only local effect, any units
     * changing locality will behave according to their state - remoteExec
     * here thus ensures disabled PATH and correct watch direction for all
     */
    [
        [_unit, {
            if (_this getVariable ["a3aa_ee_stay_and_watch_stay", false]) then {
                _this disableAI "PATH";
            };
            private _pos = _this getVariable "a3aa_ee_stay_and_watch_pos";
            if (!isNil "_pos") then {
                _this lookAt _pos;
            };
        }],
        0,
        _unit,
        { !alive _this }
    ] call a3aa_fnc_remoteCallObj;
};
