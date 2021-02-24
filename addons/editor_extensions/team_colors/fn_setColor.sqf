0 = _this spawn {
    params ["_unit", "_color"];

    /* default white color on unit creation -> no change needed */
    if (_color == "MAIN") exitWith {};

    /*
     * the game seems to ignore any color settings for a few seconds
     * after unit spawn
     * (also wait ~ for the units to be transferred)
     */
    waitUntil { !isNil "a3aa_preload_finished" };
    sleep 5;

    /*
     * technically, local check is not needed, but it prevents setting color
     * on the same unit from multiple clients
     */
    [
        [_unit, _color],
        {
            /* explicit requirement for assignTeam */
            waitUntil { !isNull player };
            (_this select 0) assignTeam (_this select 1);
        }
    ] remoteExec ["spawn", _unit];
};
