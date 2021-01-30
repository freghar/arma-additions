/*
 * players are not automatically added to curator, we need to add them here,
 * as they join, to all existing curators - this obviously needs a counterpart
 * in mkCurator to do the same on curator creation
 */

if (isDedicated) exitWith {};

0 = [] spawn {
    waitUntil { !isNull player };
    waitUntil { time > 0 };  // a3aa_insta_zeus curator instance initialized

    [player, {
        {
            _x addCuratorEditableObjects [[_this], false];
        } forEach allCurators;
    }] remoteExec ["call", 2];
};
