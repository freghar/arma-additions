params ["_module", "_value"];

if (!is3DEN) exitWith { deleteVehicle _module };

/* inhibitor present, do nothing */
private _all_logic = (all3DENEntities select 3) apply { typeOf _x };
if ("a3aa_ee_execute_code_3den_inhibit" in _all_logic) exitWith {};

private _code = compile (_value call a3aa_ee_execute_code_fnc_decomment);
if (_code isNotEqualTo {}) then {
    [_module] call _code;

    /* delay deletion beyond the current frame, the engine crashes otherwise */
    _module spawn { delete3DENEntities [_this] };
};
