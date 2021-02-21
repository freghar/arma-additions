if (isClass (configFile >> "CfgPatches" >> "ace_interaction")) exitWith {};
0 = [] spawn {
    waitUntil { !isNull player };
    [[player, "a3aa_join_group_fnc_broadcastAction"], 0, player, { !alive _this }]
        call a3aa_fnc_remoteCallObj;
    player addEventHandler ["Respawn", {
        params ["_unit", "_corpse"];
        [[_unit, "a3aa_join_group_fnc_broadcastAction"], 0, _unit, { !alive _this }]
            call a3aa_fnc_remoteCallObj;
    }];
};
