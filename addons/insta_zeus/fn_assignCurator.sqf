/*
 * like the assignCurator scripting cmd, but actually reliable
 * (the scripting cmd tends to have no effect if executed on the same frame
 *  as unassignCurator on either the same or any other Curator instance)
 */

if (!isServer) exitWith {
    _this remoteExec ["a3aa_insta_zeus_fnc_assignCurator", 2];
};

if (!canSuspend) exitWith {
    _this spawn a3aa_insta_zeus_fnc_assignCurator;
};

params ["_unit", "_curator"];

private _unassign = {
    if (!isNull getAssignedCuratorUnit _this) then {
        waitUntil {
            unassignCurator _this;
            isNull getAssignedCuratorUnit _this;
        };
    };
};

_curator call _unassign;
(getAssignedCuratorLogic _unit) call _unassign;

waitUntil {
    _unit assignCurator _curator;
    !isNull getAssignedCuratorLogic _unit;
};
