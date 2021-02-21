#include "\A3\ui_f\hpp\defineDIKCodes.inc"
#include "\A3\ui_f\hpp\defineResincl.inc"

if (is3DEN) exitWith {};

private _markrange = _this getVariable "a3aa_ee_paper_map_markrange";
private _nodelete = _this getVariable "a3aa_ee_paper_map_nodelete";

/*
 * server-side
 */

/* hash of per-UID makers */
a3aa_ee_paper_map_uidspecific = [] call a3aa_fnc_hashInit;

/* push directplay ID and per-UID makers to clients */
addMissionEventHandler ["PlayerConnected", {
    params ["_id", "_uid", "_name", "_jip", "_owner"];

    private _peruid = [a3aa_ee_paper_map_uidspecific, _uid]
        call a3aa_fnc_hashGet;
    if (isNil "_peruid") then {
        _peruid = [sideUnknown, []];
    };

    /* on the client */
    [[_id, _peruid], {
        params ["_dpid", "_peruid"];
        if (!hasInterface) exitWith {};
        a3aa_ee_paper_map_uidmarkers = _peruid;
        waitUntil { !isNull player };
        player setVariable ["a3aa_ee_paper_map_directplay_id", _dpid, true];
    }] remoteExec ["spawn", _owner];
}];
addMissionEventHandler ["HandleDisconnect", {
    params ["_unit", "_id", "_uid", "_name"];
    _unit setVariable ["a3aa_ee_paper_map_directplay_id", nil, true];
}];
// TODO: addMissionEventHandler ["TeamSwitch", { ?

/* list of permanent (never deleted) markers */
0 = [] spawn {
    waitUntil { time > 0 };
    /* all that were initially added on briefing screen */
    a3aa_ee_paper_map_permarkers = allMapMarkers select {
        _x find "_USER_DEFINED" == 0
    };
    publicVariable "a3aa_ee_paper_map_permarkers";
};


/*
 * client-side
 */

[_markrange, _nodelete]
    remoteExec ["a3aa_ee_paper_map_fnc_onClients", 0, true];

deleteVehicle _this;
