if (is3DEN) exitWith {};

params ["_unit", "_varname", "_value"];

switch (_varname) do {
    case "a3aa_ee_stay_and_watch_stay": {
        if (_value) then {
            [_unit, "PATH"] remoteExec ["disableAI"];
        };
    };
    case "a3aa_ee_stay_and_watch_watch": {
        if (_value) then {
            [_unit, _unit modelToWorld [0,100000,0]] remoteExec ["lookAt"];
        };
    };
};
