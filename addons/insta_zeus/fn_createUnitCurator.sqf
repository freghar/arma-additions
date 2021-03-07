/*
 * since this can run on a client (engine bug with 3den object expression),
 * re-exec it on server if this happens
 */
if (!isServer) exitWith {
    _this remoteExecCall ["a3aa_insta_zeus_fnc_createUnitCurator", 2];
};

/*
 * Idea:
 * Have a list of Curator objects and, as eligible units connect, assign
 * curators from this list. However create curators ONLY before simulation
 * starts - anything after that freezes the game (and can crash/desync it).
 *
 * Simply try finding a free Curator first and assign it - if there is none
 * and the mission hasn't started yet, create and assign it. This guarantees,
 * even through re-connects / JIP, that an eligible unit will always be able
 * to re-gain Curator as long as it was present on mission start.
 *
 * (IOW if 3 eligible units are present at time == 0, then 3 Curator objects
 *  are created and can be assigned/unassigned by connects/disconnects at any
 *  time during the mission.)
 *
 * If the mission already started and there's no free Curator, it means that
 * the eligible unit wasn't present at mission start (and the ones present are
 * already in game / assigned), so there's no Curator to grant.
 *
 * -------------
 * This is one of the few race-free algorithms possible.
 */

params ["_unit", "_checkbox"];
if (!_checkbox) exitWith {};

/* for singleplayer, we already have admin curator */
if (!isMultiplayer) exitWith {};

if (isNil "a3aa_insta_zeus_unit_curators") then {
    a3aa_insta_zeus_unit_curators = [];
};

private "_curator";
{
    if (isNull getAssignedCuratorUnit _x) exitWith {
        _curator = _x;
    };
} forEach a3aa_insta_zeus_unit_curators;

if (isNil "_curator" && time <= 0) then {
    _curator = ([] call a3aa_insta_zeus_fnc_mkCurator);
    a3aa_insta_zeus_unit_curators pushBack _curator;
    _unit assignCurator _curator;
} else {
    if (!isNil "_curator") then {
        _unit assignCurator _curator;
    };
};
