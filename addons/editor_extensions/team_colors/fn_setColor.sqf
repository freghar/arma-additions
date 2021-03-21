if (is3DEN) exitWith {};

/* default white color on unit creation -> no change needed */
params ["_unit", "_color"];
if (_color == "MAIN") exitWith {};

/*
 * since this can run on a client (engine bug with 3den object expression),
 * do the waiting on the server, in case the client disconnects during
 * the waiting
 */
if (!isServer) exitWith {
    _this remoteExecCall ["a3aa_ee_team_colors_fnc_setColor", 2];
};

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
    }] remoteExec ["spawn", _this];
};
