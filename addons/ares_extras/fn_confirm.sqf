/*
 * wait for the curator to confirm something (Return = yes, Escape = no)
 *
 * your code will run unscheduled and will receive no argument (or your
 * custom one)
 *
 * this function uses global vars, but is recursion-safe
 *
 * [
 *     "Select source units",
 *     {
 *         private _units = curatorSelected select 0;
 *         if (count _units == 0) exitWith {
 *             ["No units selected.", "cancel"]
 *                 call a3aa_ares_extras_fnc_curatorMsg;
 *         };
 *         [
 *             "Select target groups",
 *             [_units, {
 *                 private _units = _this;
 *                 private _groups = curatorSelected select 1;
 *                 if (count _groups > 0) then {
 *                     systemChat format ["src units: %1", _units];
 *                     systemChat format ["tgt groups: %1", _groups];
 *                 };
 *             }]
 *         ] call a3aa_ares_extras_fnc_confirm;
 *     }
 * ] call a3aa_ares_extras_fnc_confirm;
 */

#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"
#include "\A3\ui_f\hpp\defineDIKCodes.inc"

params ["_msg", "_code"];

if (_code isEqualType []) then {
    a3aa_ares_extras_confim_codearg = _code select 0;
    a3aa_ares_extras_confim_code = _code select 1;
} else {
    a3aa_ares_extras_confim_code = _code;
};

disableSerialization;
private _display = findDisplay IDD_RSCDISPLAYCURATOR;
if (isNull _display) exitWith {};

/* another confirmation in progress */
if (!isNil "a3aa_ares_extras_confim_EH") then {
    _display displayRemoveEventHandler ["KeyDown", a3aa_ares_extras_confim_EH];
};

/* no _thisEventHandler for displayAddEventHandler */
a3aa_ares_extras_confim_EH = _display displayAddEventHandler ["KeyDown",
{
    params ["_display", "_key"];
    switch (_key) do {
        case DIK_ESCAPE: {
            _display displayRemoveEventHandler
                ["KeyDown", a3aa_ares_extras_confim_EH];
            a3aa_ares_extras_confim_EH = nil;
            ["Cancelled.", "cancel"] call a3aa_ares_extras_fnc_curatorMsg;
            true;
        };
        case DIK_NUMPADENTER;
        case DIK_RETURN: {
            _display displayRemoveEventHandler
                ["KeyDown", a3aa_ares_extras_confim_EH];
            a3aa_ares_extras_confim_EH = nil;
            ["Confirmed.", "normal"] call a3aa_ares_extras_fnc_curatorMsg;
            if (isNil "a3aa_ares_extras_confim_codearg") then {
                call a3aa_ares_extras_confim_code;
            } else {
                a3aa_ares_extras_confim_codearg
                    call a3aa_ares_extras_confim_code;
            };
            true;
        };
        default {
            false;
        };
    };
}];

if (!(_msg isEqualTo "")) then {
    [_msg, "action"] call a3aa_ares_extras_fnc_curatorMsg;
};
