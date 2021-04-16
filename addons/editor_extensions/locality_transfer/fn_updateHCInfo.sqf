/*
 * run on each HC and regularly push client-side info to the server
 */

if (isServer || hasInterface) exitWith {};

private _send_update = {
    /* ~0.14ms on 288 groups */
    private _grps = { local _x } count allGroups;
    [[clientOwner, _grps, diag_fps, name player, getPlayerUID player], {
        params ["_owner", "_grps", "_fps", "_name", "_uid"];
        a3aa_ee_locality_transfer_hcdata
            set [_owner, [_grps, _fps, _name, _uid]];
    }] remoteExec ["call", 2];
};

waitUntil { !isNil "BIS_fnc_init" };
waitUntil { !isNull player };

/* send one initial update before game start */
[] call _send_update;

/* wait for game start + sleep to become reliable (for JIP) */
waitUntil { !isNil "a3aa_preload_finished" };

/* keep sending regular updates */
waitUntil {
    [] call _send_update;
    sleep 1.5;
    false;
};
