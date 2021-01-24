params ["_units", "_code", "_transform"];

switch (_transform) do {
    case "groups": {
        private _groups = [];
        { _groups pushBackUnique group _x } forEach _units;
        _units = _groups;
    };
    case "vehicles": {
        _units = _units apply { vehicle _x };
        _units = _units select {
            _x isKindOf "Air" ||
            _x isKindOf "Tank" ||
            _x isKindOf "Car" ||
            _x isKindOf "Ship"
        };
    };
};

/* check after transform */
if (_units isEqualTo []) exitWith {
    ["Nothing valid selected.", "cancel"]
        call a3aa_ares_extras_fnc_curatorMsg;
};

if (_code isEqualType []) then {
    [_units, _code select 0] call (_code select 1);
} else {
    _units call _code;
};
