#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

if (!([] call a3aa_insta_arsenal_fnc_allowed)) exitWith {};

switch _this do {
    case "open": {
        /*
         * if remotely controlling a unit, opening BI Arsenal breaks everything
         * on v1.62+, making you unable to ever open the Arsenal UI without
         * rejoining the mission, so let's prevent it here
         */
        if (([] call CBA_fnc_currentUnit) != player) exitWith {};
        ["Open", true] spawn BIS_fnc_arsenal;
    };
    case "ace_open": {
        if (!isNil "ace_arsenal_fnc_openBox") then {
            [ace_player, ace_player, true] call ace_arsenal_fnc_openBox;
        } else {
            /* fall back to BI arsenal */
            if (([] call CBA_fnc_currentUnit) != player) exitWith {};
            ["Open", true] spawn BIS_fnc_arsenal;
        };
    };
    case "spawn": {
        private "_pos";
        if (!isNull findDisplay IDD_RSCDISPLAYCURATOR) then {
            /* has curator interface open, use mouse cursor position */
            _pos = screenToWorld getMousePosition;
        } else {
            _pos = screenToWorld [0.5, 0.5];
        };
        _pos params ["_px", "_py"];
        private _box = createVehicle ["Land_RotorCoversBag_01_F", [_px, _py, 50], [], 0, "CAN_COLLIDE"];
        [(getAssignedCuratorLogic player), [[_box], false]] remoteExec ["addCuratorEditableObjects", 2];
        ["AmmoboxInit", [_box, true]] spawn BIS_fnc_arsenal;
        if (!isNil "ace_arsenal_fnc_initBox") then {
            [_box, true] call ace_arsenal_fnc_initBox;
        };
    };
};
nil;
