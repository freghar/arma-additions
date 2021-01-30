/*
 * this is a global replacement for BIS_fnc_curatorRespawn which does two
 * independent things:
 * - adds respawned units to all curators that had (now dead) units added
 * - assigns curator to a respawned unit if the old one had Curator
 *
 * unfortunately, it doesn't work on dedicated as assignCurator seems to be
 * ignored for up to ~5 seconds after respawn
 */

addMissionEventHandler ["EntityRespawned", {
    params ["_new", "_old"];

    /* any unit respawned, add it to curators in which it was editable */
    {
        _x addCuratorEditableObjects [[_new], true];
        //_x removeCuratorEditableObjects [[_old], true];
    } foreach (objectcurators _old);

    /* curator controller/player itself respawned, re-assign curator obj */
    private _curator = getAssignedCuratorLogic _old;
    if (!isNull _curator) then {
        unassignCurator _curator;
        0 = [_curator, _new] spawn {
            params ["_curator", "_new"];
            waitUntil {
                _new assignCurator _curator;
                !isNull getAssignedCuratorUnit _curator;
            };
        };
    };
}];
