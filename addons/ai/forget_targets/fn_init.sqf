[
    "a3aa_ai_forget_targets_older_than",
    "SLIDER",
    ["Forget targets older than", "Prevent AI being fixated on and hunt targets they haven't spotted for this many seconds.\nSmaller values result in AI more responsive to movement, but less focused on engaging targets.\nLarger values feel more realistic since AI don't give up that quick.\n\nSet to 0 to disable this functionality."],
    ["Arma Additions", "AI"],
    [
        0,    /* min */
        300,  /* max */
        60,   /* default slider */
        0     /* nr. of decimal digits */
    ],     /* default */
    true,  /* isGlobal */
    nil,   /* script */
    true   /* needRestart */
] call CBA_settings_fnc_init;


["CBA_settingsInitialized", {
    if (a3aa_ai_forget_targets_older_than <= 0) exitWith {};
    if (!isServer) exitWith {};
    [
        {
            allGroups;
        },
        {
            private _leader = leader _this;
            if (!local _leader || {_leader in allPlayers}) exitWith {};
            private _all = _leader targets [true];
            if (_all isEqualTo []) exitWith {};
            private _new = _leader targets [true, 0, [], a3aa_ai_forget_targets_older_than];
            private _old = _all - _new;
            {
                _this forgetTarget _x;
            } forEach _old;
        },
        10
    ] call a3aa_fnc_balancePerFrame;
}] call CBA_fnc_addEventHandler;
