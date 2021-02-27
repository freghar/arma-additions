#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

if (!([] call a3aa_insta_arsenal_fnc_allowed)) exitWith {};

private _get_unit_for_open = {
    if (!isNull findDisplay IDD_RSCDISPLAYCURATOR) exitWith {
        private _sel = curatorSelected select 0;
        if (_sel isNotEqualTo []) then {
            _sel select 0;
        } else {
            objNull;
        };
    };
    [] call CBA_fnc_currentUnit;
};

switch _this do {
    case "open": {
        private _unit = [] call _get_unit_for_open;
        if (isNull _unit) exitWith {};
        /*
         * if remotely controlling a unit, opening BI Arsenal breaks everything
         * on v1.62+, making you unable to ever open the Arsenal UI without
         * rejoining the mission, so let's prevent it here
         */
        if (_unit != player && isNull findDisplay IDD_RSCDISPLAYCURATOR) exitWith {};
        ["Open", [true, nil, _unit]] call BIS_fnc_arsenal;
    };
    case "ace_open": {
        private _unit = [] call _get_unit_for_open;
        if (isNull _unit) exitWith {};
        if (!isNil "ace_arsenal_fnc_openBox") then {
            [_unit, _unit, true] call ace_arsenal_fnc_openBox;
        } else {
            /* fall back to BI arsenal */
            "open" call a3aa_insta_arsenal_fnc_arsenal;
        };
    };
    case "spawn": {
        private ["_pos", "_src", "_tgt"];
        if (!isNull findDisplay IDD_RSCDISPLAYCURATOR) then {
            /* has curator interface open, use mouse cursor position */
            _src = getPosASL curatorCamera;
            _tgt = AGLtoASL screenToWorld getMousePosition;
        } else {
            /* 1st/3rd person, use middle of the screen */
            _src = AGLtoASL positionCameraToWorld [0,0,0];
            _tgt = AGLtoASL screenToWorld [0.5,0.5];
        };
        /* try intersecting surface first, fall back to target position */
        private _sfcs = lineIntersectsSurfaces [_src, _tgt, [] call CBA_fnc_currentUnit];
        if (_sfcs isNotEqualTo []) then {
            _pos = (_sfcs select 0) select 0;
        } else {
            _pos = _tgt;
        };
        private _box = createVehicle ["Land_RotorCoversBag_01_F", ASLtoATL _pos, [], 0, "CAN_COLLIDE"];
        [(getAssignedCuratorLogic player), [[_box], false]] remoteExec ["addCuratorEditableObjects", 2];
        ["AmmoboxInit", [_box, true]] spawn BIS_fnc_arsenal;
        if (!isNil "ace_arsenal_fnc_initBox") then {
            [_box, true] call ace_arsenal_fnc_initBox;
        };
    };
};
nil;
