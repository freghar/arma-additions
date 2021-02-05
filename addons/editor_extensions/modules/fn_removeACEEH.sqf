if (is3DEN) exitWith {};

private _cond = _this getVariable "a3aa_ee_remove_ace_eh_cond";

[
    compile _cond,
    {
        a3aa_ee_remove_ace_eh_cond_code = _this;
        [
            "CAManBase",
            "InitPost",
            {
                params ["_unit"];
                if (_unit call a3aa_ee_remove_ace_eh_cond_code) then {
                    private _ehid = _unit getvariable "ace_medical_HandleDamageEHID";
                    if (!isNil "_ehid") then {
                        _unit removeEventHandler ["HandleDamage", _ehid];
                    };
                };
            },
            true,
            nil,
            true
        ] call CBA_fnc_addClassEventHandler;
    }
] remoteExec ["call", 0, true];

deleteVehicle _this;
