/*
 * custom message in the top bar, like BIS_fnc_showCuratorFeedbackMessage
 * but with customizable sound
 */

#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

/* sound: normal, action, cancel, ... or classname .. or "" for silent */
params ["_msg", ["_sound", "normal"]];

disableSerialization;
private _display = findDisplay IDD_RSCDISPLAYCURATOR;
private _ctrl = _display displayCtrl IDC_RSCDISPLAYCURATOR_FEEDBACKMESSAGE;
if (isNull _ctrl) exitWith {};

switch (_sound) do {
    case "normal": { playSound "RscDisplayCurator_error01" };
    case "action": { playSound "FD_Finish_F" };
    case "cancel":  { playSound "FD_Start_F" };
    case "": {};
    default { playSound _sound };
};

/*
 * replicate messaging logic from BIS_fnc_showCuratorFeedbackMessage,
 * including the msg fade - use BIS identifier for the script, so that
 * any BIS_fnc_showCuratorFeedbackMessage call can terminate it, making
 * this function fully BIS_fnc_showCuratorFeedbackMessage compatible
 */

_ctrl ctrlSetText _msg;
_ctrl ctrlSetFade 1;
_ctrl ctrlCommit 0;
_ctrl ctrlSetFade 0;
_ctrl ctrlCommit 0.1;

if (!isNil "BIS_fnc_moduleCurator_feedbackMessage") then {
    terminate BIS_fnc_moduleCurator_feedbackMessage;
};
BIS_fnc_moduleCurator_feedbackMessage = _ctrl spawn {
    disableSerialization;
    uiSleep 3;
    _this ctrlSetFade 1;
    _this ctrlCommit 0.5;
};
