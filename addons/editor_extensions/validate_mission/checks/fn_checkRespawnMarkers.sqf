/*
 * if respawn is set to custom position, ensure that there is at least one
 * relevant/usable respawn marker for each playable unit
 *
 * - don't do any advanced per-side checking (respawn_west, etc.), the engine
 *   has some stupid fallbacks (respawn_whatever == respawn_wesy == respawn)
 *   and enforcing respawn_<nr> would break valid cases of multiple generic
 *   respawns (ie. respawn_base, respawn_fob, etc.), so we can't even check
 *   for typos
 */

private _respawn = "Multiplayer" get3DENMissionAttribute "Respawn";
/* 3 = custom position */
if (_respawn != 3) exitWith {
    [["Respawn markers", true]];
};

private _found = (all3DENEntities select 5) findIf {
    _x select [0,7] == "respawn";
};

private _msg = [
    "Respawn is set to custom position and no 'respawn*' marker found."
];

if (_found == -1) then {
    [["Respawn markers", false, [], _msg]];
} else {
    [["Respawn markers", true]];
};
