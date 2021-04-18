[
    "a3aa_ai_crew_in_immobile_enabled",
    "CHECKBOX",
    ["Crew stays in immobile", "Let AI vehicle crew stay inside an otherwise immobile vehicle (wheels destroyed).\nIf the vehicle takes critical damage, the crew still dismounts."],
    ["Arma Additions", "AI"],
    true,  /* default */
    true   /* isGlobal */
] call CBA_settings_fnc_init;

[
    "a3aa_ai_disable_remote_raycasts",
    "CHECKBOX",
    ["Disable remote raycasts", "Save some CPU time by not calculating visibility raycasts (knowsAbout, etc.) for purely REMOTE groups.\nUnless you need to query AI targets of remote AI units from script, this should be safe.\n\nSee the disableRemoteSensors command on BI wiki."],
    ["Arma Additions", "AI"],
    true,  /* default */
    true,  /* isGlobal */
    {
        disableRemoteSensors _this;
    }
] call CBA_settings_fnc_init;

[
    "a3aa_ai_alive_group_leader",
    "CHECKBOX",
    ["Ensure alive group leader", "When a group leader dies, it takes forever (~30 seconds) for the group to realize it and switch to a new one.\nThis is time spent holding in position, doing nothing. Try to find a new alive leader and switch to it as soon\nas the current one dies, speeding up AI combat movement."],
    ["Arma Additions", "AI"],
    true,  /* default */
    true   /* isGlobal */
] call CBA_settings_fnc_init;

[
    "a3aa_ai_disable_voice",
    "LIST",
    ["Disable AI voices", "Make AI soldiers silent (not shout orders out loud). Useful for a more suprising/deadly experience."],
    ["Arma Additions", "AI"],
    [
        ["nobody","regulars","all"],
        ["Leave enabled","Disable for trained armies","Disable for all"],
        0
    ],     /* default */
    true   /* isGlobal */
] call CBA_settings_fnc_init;


["CBA_settingsInitialized", {
    if (a3aa_ai_crew_in_immobile_enabled) then {
        {
            [
                _x,
                "init",
                {
                    (_this select 0) allowCrewInImmobile true;
                },
                true,
                [],
                true
            ] call CBA_fnc_addClassEventHandler;
        } forEach ["Car", "Air", "Tank", "Ship"];
    };

    if (a3aa_ai_alive_group_leader) then {
        /*
         * some CfgVehicles override CBA XEHs, for which CBA adds workarounds
         * via always-running loops, but only for 'init', so handle this some
         * other way than a 'killed' EH
         */
        addMissionEventHandler ["EntityKilled", {
            params ["_unit"];
            private _grp = group _unit;
            if (leader _grp == _unit) then {
                private _units = units _grp;
                private _idx = _units findIf { alive _x };
                if (_idx != -1) then {
                    _grp selectLeader (_units select _idx);
                };
            };
        }];
    };

    if (a3aa_ai_disable_voice != "nobody") then {
        [
            "CAManBase",
            "InitPost",
            {
                params ["_unit"];
                if (a3aa_ai_disable_voice == "regulars"
                    && _unit call a3aa_fnc_isGuerrilla) exitWith {};
                _unit setSpeaker "NoVoice";
            },
            true,
            [],
            true
        ] call CBA_fnc_addClassEventHandler;
    };
}] call CBA_fnc_addEventHandler;
