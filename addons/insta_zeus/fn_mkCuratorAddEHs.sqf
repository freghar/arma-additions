params ["_logic"];

if (!hasInterface) exitWith {};
waitUntil { !isNull _logic };

/* add all players - done in fn_addPlayer */
//_logic addCuratorEditableObjects [allPlayers, false];

/*
 * ModuleCurator_F has function="BIS_fnc_moduleCurator", the following
 * is taken from it to register vanilla Zeus behavior
 */
_logic addeventhandler ["curatorFeedbackMessage",{_this call bis_fnc_showCuratorFeedbackMessage;}];
_logic addeventhandler ["curatorPinged",{_this call bis_fnc_curatorPinged;}];
_logic addeventhandler ["curatorObjectPlaced",{_this call bis_fnc_curatorObjectPlaced;}];
_logic addeventhandler ["curatorObjectEdited",{_this call bis_fnc_curatorObjectEdited;}];
_logic addeventhandler ["curatorWaypointPlaced",{_this call bis_fnc_curatorWaypointPlaced;}];
_logic addeventhandler ["curatorObjectDoubleClicked",{(_this select 1) call bis_fnc_showCuratorAttributes;}];
_logic addeventhandler ["curatorGroupDoubleClicked",{(_this select 1) call bis_fnc_showCuratorAttributes;}];
_logic addeventhandler ["curatorWaypointDoubleClicked",{(_this select 1) call bis_fnc_showCuratorAttributes;}];
_logic addeventhandler ["curatorMarkerDoubleClicked",{(_this select 1) call bis_fnc_showCuratorAttributes;}];

/*
 * don't call bis_fnc_curatorRespawn, it doesn't seem to work in dedicated
 * multiplayer because of assignCurator not working for about 1-3 seconds
 * after player respawns
 * - for a3aa_insta_zeus_admin_curator itself, we don't care as it's re-assigned on
 *   the next fn_maintainCurator loop iteration
 */
//player call bis_fnc_curatorRespawn;

/*
 * add newly placed units to all Curators whose controlling units (players)
 * are of the same side
 */
_logic addEventHandler ["CuratorObjectPlaced", {
    params ["_curator", "_unit"];
    private _me = getAssignedCuratorUnit _curator;
    private _editfor = (
        (allCurators - [_curator]) select {
            side getAssignedCuratorUnit _x == side _me;
        }
    );
    [[_unit, _editfor], {
        params ["_unit", "_editfor"];
        {
            _x addCuratorEditableObjects [[_unit], true];
        } forEach _editfor;
    }] remoteExec ["call", 2];
}];
