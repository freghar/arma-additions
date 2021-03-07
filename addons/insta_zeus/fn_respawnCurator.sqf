if (!isServer) exitWith {};

addMissionEventHandler ["HandleDisconnect", {
    params ["_unit", "_id", "_uid", "_name"];
    private _curator = getAssignedCuratorLogic _unit;
    if (!isNull _curator) then {
        unassignCurator _curator;
    };
}];

addMissionEventHandler ["EntityRespawned", {
	params ["_entity", "_corpse"];
    private _curator = getAssignedCuratorLogic _corpse;
    if (!isNull _curator) then {
        unassignCurator _curator;
        0 = [_entity, _curator] spawn {
            params ["_unit", "_curator"];
            waitUntil {
                _unit assignCurator _curator;
                isNull _unit || !isNull getAssignedCuratorLogic _unit;
            };
        };
    };
}];
