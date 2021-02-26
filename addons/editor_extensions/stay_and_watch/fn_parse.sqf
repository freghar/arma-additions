if (is3DEN) exitWith {};

0 = _this spawn {
    waitUntil { !isNil "BIS_fnc_init" };
    private _ents = synchronizedObjects _this;

    private _layer = _this getVariable "a3aa_ee_stay_and_watch_layer";
    if (_layer isNotEqualTo "") then {
        /* avoid duplicate entities */
        _ents insert [-1, (getMissionLayerEntities _layer) select 0, true];
    };

    /*
     * disableAI and doWatch do actually have only local effect, any units
     * changing locality will behave according to their state - remoteExec
     * here thus ensures disabled PATH and correct watch direction for all
     */

    {
        [
            [[_x, _x modelToWorld [0,100000,0]], {
                params ["_unit", "_watchpos"];
                _unit disableAI "PATH";
                _unit doWatch _watchpos;
            }],
            0,
            _x,
            { !alive _this }
        ] call a3aa_fnc_remoteCallObj;
    } forEach _ents;

    deleteVehicle _this;
};
