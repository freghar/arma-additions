if (is3DEN) exitWith {};

/* default white color on unit creation -> no change needed */
params ["_unit", "_color"];
if (_color == "MAIN") exitWith {};

0 = _this spawn {
    /*
     * the game seems to ignore any color settings for a few seconds
     * after unit spawn
     * (also wait ~ for the units to be transferred in case of JIP)
     * NOTE that here, we're still running only on the server
     */
    sleep 5;

    [_this, {
        if (!hasInterface) exitWith {};
        params ["_unit", "_color"];
        /* explicit requirement for assignTeam */
        waitUntil { !isNull player };
        waitUntil { !isNil "a3aa_preload_finished" };
        _unit assignTeam _color;
    }] remoteExec ["spawn", _unit];
};
