/*
 * the engine copies object variables to the respawned unit,
 * so clear the stored chestpack, if any
 */

if (!hasInterface) exitWith {};

0 = [] spawn {
    waitUntil { !isNull player };
    player addEventHandler ["Respawn", {
        params ["_unit", "_corpse"];
        _unit setVariable ["a3aa_chestpack_pack", nil, true];
    }];
};
