/*
 * players are not automatically added to curator, we need to add them here,
 * as they join, to all existing curators - this obviously needs a counterpart
 * in mkCurator to do the same on curator creation
 */

if (!hasInterface) exitWith {};

0 = [] spawn {
    waitUntil { !isNull player };
    /* also wait for admin curator to be created */
    waitUntil { !isNil "a3aa_preload_finished" };

    /* add current player now */
    [player, {
        {
            _x addCuratorEditableObjects [[_this], false];
        } forEach (allCurators select {
            _x isKindOf "a3aa_insta_zeus_dumb_curator";
        });
    }] remoteExec ["call", 2];

    /* add any respawned player unit */
    player addEventHandler ["Respawn", {
        params ["_unit", "_corpse"];
        [_unit, {
            {
                _x addCuratorEditableObjects [[_this], false];
            } forEach (allCurators select {
                _x isKindOf "a3aa_insta_zeus_dumb_curator";
            });
        }] remoteExec ["call", 2];
    }];
};
