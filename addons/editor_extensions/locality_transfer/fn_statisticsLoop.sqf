/*
 * draw server + HC group nr. + FPS statistics on the map, globally
 */

if (!isNil "a3aa_ee_locality_transfer_statistics_running") exitWith {};
a3aa_ee_locality_transfer_statistics_running = true;

private _fmt_marker = {
    if (_this <= 2) then {
        format ["Server  Owner:2  FPS:%1", diag_fps toFixed 1];
    } else {
        private _data = a3aa_ee_locality_transfer_hcdata get _this;
        _data params ["_grpcnt", "_fps", "_name", "_uid"];
        format [
            "%1 (%2)  Owner:%3  Groups:%4  FPS:%5",
            _name, _uid, _this, _grpcnt, _fps toFixed 1
        ];
    };
};

private _redraw_markers = {
    params ["_old", "_new"];
    {
        private _mark = format ["a3aa_ee_locality_transfer_mark_%1", _x];
        deleteMarker _mark;
    } forEach ([2] + _old);
    private _posx = worldSize/20;
    private _posy = -worldSize/60;
    private _spacing = -_posy;
    _new sort true;
    {
        private _mark = createMarker [
            format ["a3aa_ee_locality_transfer_mark_%1", _x],
            [_posx, _posy - _forEachIndex * _spacing]
        ];
        _mark setMarkerType "mil_dot";
        _mark setMarkerSize [0, 0];
        _mark setMarkerColor "ColorWEST";  /* good for dark & light bg */
        _mark setMarkerText (_x call _fmt_marker);
    } forEach ([2] + _new);
};

private _update_markers = {
    {
        private _mark = format ["a3aa_ee_locality_transfer_mark_%1", _x];
        _mark setMarkerText (_x call _fmt_marker);
    } forEach ([2] + _this);
};

private _existing = [];
waitUntil {
    isNil {
        private _hcs = [] call a3aa_ee_locality_transfer_fnc_getAllHCs;
        if (!(_hcs call a3aa_ee_locality_transfer_fnc_areHCsReady)) exitWith {};

        /* if the list of HCs remained the same, just update texts, otherwise redraw markers */
        if (count _hcs == count _existing && {count _hcs == count (_existing arrayIntersect _hcs)}) then {
            _existing call _update_markers;
        } else {
            [_existing, _hcs] call _redraw_markers;
            _existing = _hcs;
        };
    };
    sleep 1;
    false;
};
