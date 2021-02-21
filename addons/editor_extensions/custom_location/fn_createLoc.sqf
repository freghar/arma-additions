params ["_pos", "_area", "_locname", "_loctype", "_locvar", "_delcorpse"];
_area params ["_sizex", "_sizey", "_orient", "_rect"];

private _loc = createLocation [_loctype, _pos, _sizex, _sizey];
_loc setText _locname;
_loc setName _locname;  /* ?? any use? */
_loc setRectangular _rect;
_loc setDirection _orient;
if (_locvar != "") then {
    missionNamespace setVariable [_locvar, _loc];
};

if (isServer && _delcorpse) then {
    /* unique internal variable name, based on position */
    private _internal_loc = "loc_" + ((str position _loc) call BIS_fnc_filterString);
    missionNamespace setVariable [_internal_loc, _loc];
    addMissionEventHandler ["HandleDisconnect", compile (
        "if (position (_this select 0) in " + _internal_loc + ") then {" +
            "deleteVehicle (_this select 0);" +
        "}; false"
    )];
    /* give a few seconds to Respawn EHs like gear save/restore,
     * BIS_fnc_curatorRespawn, etc. to work with the corpse
     * - hideBody doesn't work reliably in MP */
    addMissionEventHandler ["EntityRespawned", compile (
        "if (position (_this select 1) in " + _internal_loc + ") then {" +
            "0 = (_this select 1) spawn { sleep 3; deleteVehicle _this };" +
        "}; false"
    )];
};
