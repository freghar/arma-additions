if (is3DEN) exitWith {};

private _enable = _this getVariable "a3aa_ee_execute_code_enabledexec";
if (!_enable) exitWith {};

private _execonmp = _this getVariable "a3aa_ee_execute_code_execonmp";
private _forjip = _this getVariable "a3aa_ee_execute_code_forjip";
private _keepmodule = _this getVariable "a3aa_ee_execute_code_keepmodule";

/* unique internal variable name, based on position */
private _uid = "a3aa_ee_execute_code_" + ((str position _this) call BIS_fnc_filterString);

[
    _this getVariable "a3aa_ee_execute_code_execenv",
    _this getVariable "a3aa_ee_execute_code_runoninit",
    _this getVariable "a3aa_ee_execute_code_runonrespawn",
    compile (
        (_this getVariable "a3aa_ee_execute_code_code")
            call a3aa_ee_execute_code_fnc_decomment
    ),
    _keepmodule,
    _this,
    _uid
] remoteExecCall ["a3aa_ee_execute_code_fnc_execRuntimeClients", _execonmp, _forjip];

if (!_keepmodule) then {
    deleteVehicle _this;
};
