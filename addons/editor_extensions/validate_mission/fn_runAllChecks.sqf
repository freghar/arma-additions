if (!is3DEN) exitWith {};

if (isNil "a3aa_ee_validate_mission_checks") exitWith {};

private _annotate_ents = {
    private _strings = _this apply {
        " - " + (_x call a3aa_ee_validate_mission_fnc_getEntityInfo) + endl;
    };
    _strings joinString "";
};

private _failed = 0;

private _all_results = [];
{
    private _results = [] call _x;
    {
        _x params ["_header", "_pass", ["_ents",[]], ["_description",[]]];
        private _result = format [
            "%1: %2%3",
            _header,
            if (_pass) then { "PASS" } else { "FAIL" },
            endl
        ];
        _result = _result + (_ents call _annotate_ents);
        private _description_str = (_description apply {
            "    " + _x + endl;
        }) joinString "";
        if (_description_str != "") then {
            _result = _result + endl + _description_str + endl;
        };
        _all_results pushBack _result;
        if (!_pass) then { _failed = _failed + 1 };
    } forEach _results;
} forEach a3aa_ee_validate_mission_checks;

copyToClipboard (
    "Mission validation report" + endl +
    "-------------------------" + endl +
    (_all_results joinString "")
);

if (_failed > 0) then {
    [format ["%1 validity checks FAILED, report in clipboard.", _failed], 1] call BIS_fnc_3DENNotification;
} else {
    ["All validity checks PASSED, report in clipboard.", 0] call BIS_fnc_3DENNotification;
};
