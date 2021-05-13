[
    "a3aa_ai_crew_in_immobile_enabled",
    "CHECKBOX",
    ["Crew stays in immobile", "Let AI vehicle crew stay inside an otherwise immobile vehicle (wheels destroyed).\nIf the vehicle takes critical damage, the crew still dismounts."],
    ["Arma Additions", "AI"],
    true,  /* default */
    true,  /* isGlobal */
    nil,   /* script */
    true   /* needRestart */
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
    "a3aa_ai_ungroup_dead",
    "CHECKBOX",
    ["Ungroup dead soldiers", "When a group leader dies, it takes forever (~30 seconds) for the group to realize it and switch to a new one.\nThis is time spent holding in position, doing nothing. Similarly, when a non-leader member dies, it delays\nthe group if it's waiting on that member to do a bounding move.\nFix both by removing dead soldiers from their groups immediately on death."],
    ["Arma Additions", "AI"],
    true,  /* default */
    true,  /* isGlobal */
    nil,   /* script */
    true   /* needRestart */
] call CBA_settings_fnc_init;

[
    "a3aa_ai_disable_voice",
    "CHECKBOX",
    ["Disable AI voices", "Make AI soldiers silent (not shout orders out loud). Useful for a more suprising/deadly experience."],
    ["Arma Additions", "AI"],
    true,  /* default */
    true,  /* isGlobal */
    nil,   /* script */
    true   /* needRestart */
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

    if (a3aa_ai_ungroup_dead && isServer) then {
        /*
         * some CfgVehicles override CBA XEHs, for which CBA adds workarounds
         * via always-running loops, but only for 'init', so handle this some
         * other way than a 'killed' EH
         */
        a3aa_ai_ungroup_dead_grp = grpNull;
        addMissionEventHandler ["EntityKilled", {
            params ["_unit"];
            if (isPlayer _unit || _unit in playableUnits) exitWith {};
            if (_unit isKindOf "CAManBase") then {
                if (isNull a3aa_ai_ungroup_dead_grp) then {
                    a3aa_ai_ungroup_dead_grp = createGroup civilian;
                };
                [_unit] joinSilent a3aa_ai_ungroup_dead_grp;
            };
        }];
    };

    if (a3aa_ai_disable_voice) then {
        [
            "CAManBase",
            "InitPost",
            {
                params ["_unit"];
                _unit setSpeaker "NoVoice";
            },
            true,
            [],
            true
        ] call CBA_fnc_addClassEventHandler;
    };
}] call CBA_fnc_addEventHandler;
