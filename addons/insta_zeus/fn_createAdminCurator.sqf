if (isServer) then {
    a3aa_insta_zeus_admin_curator = [] call a3aa_insta_zeus_fnc_mkCurator;
    publicVariable "a3aa_insta_zeus_admin_curator";
};

/*
 * take care of assigned/unassigned curator over time, watching for when
 * a client logs in/out of the admin role
 * - since we can't do serverCommandAvailable from the server .. and since
 *   iterating over allPlayers, applying 'admin' to figure out which one is
 *   the admin, is expensive, run the following everywhere and just let
 *   the server know who to assign the curator to
 */

if (!hasInterface) exitWith {};

0 = [] spawn {
    waitUntil { !isNil "a3aa_insta_zeus_admin_curator" };
    private _curator = a3aa_insta_zeus_admin_curator;

    waitUntil { !isNull player };

    if (!isMultiplayer) exitWith {
        /* always assign in singleplayer */
        player assignCurator _curator;
    };

    /* wait for any other unit-linked curators to take over */
    waitUntil { !isNil "a3aa_preload_finished" };
    sleep 5;
    while {true} do {
        /* #logout works only on dedicated, #kick is on hosted as well */
        if (serverCommandAvailable "#kick") then {
            if (isNull getAssignedCuratorLogic player) then {
                _curator remoteExec ["unassignCurator", 2];
                [player, _curator] remoteExec ["assignCurator", 2];
            };
        } else {
            /* only if the assigned curator is our global one */
            if (_curator == getAssignedCuratorLogic player) then {
                _curator remoteExec ["unassignCurator", 2];
            };
        };
        sleep 1;
    };
};
