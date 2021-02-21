#include "\A3\ui_f\hpp\defineDIKCodes.inc"
#include "\A3\ui_f\hpp\defineResincl.inc"

if (!hasInterface) exitWith {};

params ["_markrange", "_nodelete"];

waitUntil { !isNull player };
waitUntil { !isNil "a3aa_ee_paper_map_permarkers" };
private _permarkers = a3aa_ee_paper_map_permarkers;

waitUntil { !isNil "a3aa_ee_paper_map_uidmarkers" };
a3aa_ee_paper_map_uidmarkers params ["_side", "_prev"];
private _uidmarkers = [];
if (playerSide == _side) then {
    _uidmarkers = _prev;
};

/* prevent marker deletion after mission start */
if (_nodelete) then {
    waitUntil { !isNull findDisplay IDD_MAIN_MAP };
    (findDisplay IDD_MAIN_MAP) displayAddEventHandler ["KeyDown", {
        (_this select 1) == DIK_DELETE;
    }];
};

/*
 * on JIP, delete any new/unknown markers beyond the ones from briefing
 * and uid-specific ones; this prevents special case where a JIP player
 * would receive markers from players nearby the spawn point due to them
 * being technically within _markrange
 */
if (didJIP) then {
    {
        deleteMarkerLocal _x;
    } forEach (allMapMarkers select {
        _x find "_USER_DEFINED" == 0
        && !(_x in _permarkers)
        && !(_x in _uidmarkers)
    });
};

private _nextsync = 0;

/* on ~ every frame */
waitUntil {
    /* nearEntities & other cmds ignore crew */
    private _players = allPlayers select {
        alive _x && { player distance _x < _markrange }
    };
    private _dpids = _players apply {
        _x getVariable "a3aa_ee_paper_map_directplay_id"
    };
    _dpids = _dpids - [nil];

    private _markers = allMapMarkers select {
        _x find "_USER_DEFINED" == 0
        && !(_x in _permarkers)
        && !(_x in _uidmarkers)
    };

    {
        private _dpid = parseNumber (_x select [15]);
        if (_dpid in _dpids) then {
            _uidmarkers pushBack _x;
        } else {
            deleteMarkerLocal _x;
        };
    } forEach _markers;

    /* save to server every 10-20 seconds */
    if (time > _nextsync) then {
        [[getPlayerUID player, [playerSide, _uidmarkers]], {
            params ["_uid", "_data"];
            [a3aa_ee_paper_map_uidspecific, _uid, _data]
                call a3aa_fnc_hashSet;
        }] remoteExec ["call", 2];
        _nextsync = time + 10 + random 10;
    };

    false;
};
