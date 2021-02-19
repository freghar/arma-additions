/*
 * draw soldier / group icons on each frame
 */

_this ctrlAddEventHandler ["Draw", {
    params ["_ctrl"];

    /*
     * group icons (NATO)
     * - only if High Command icons are hidden
     */
    if (!(groupIconsVisible select 0)) then {
        {
            _x params ["_leader", "_icon", "_color", "_name"];
            if (_name != "") then {
                _ctrl drawIcon [
                    "#(rgb,1,1,1)color(1,1,1,0)",
                    [0,0,0,1],
                    _leader,
                    26,
                    26,
                    0,
                    _name,
                    0,
                    0.04,
                    "RobotoCondensed",
                    "right"
                ];
            };
            _ctrl drawIcon [
                _icon,
                _color,
                _leader,
                26,
                26,
                0
            ];
        } forEach a3aa_map_trackers_groups;
    };

    /*
     * lines between unit (soldier) icons
     */
    private _calc_alpha = {
        /* fade gradually on the last 10% of distance */
        private _dist_from_edge = a3aa_map_trackers_unit_dist - _this;
        (_dist_from_edge/(a3aa_map_trackers_unit_dist*0.1)) max 0 min 1;
    };
    {
        _x params ["_src", "_dst"];
        private _maxdist = (player distance _src) max (player distance _dst);
        _ctrl drawLine [
            _src,
            _dst,
            [0, 0, 1, 0.5*(_maxdist call _calc_alpha)]
        ];
    } forEach a3aa_map_trackers_unit_lines;

    /*
     * unit (soldier) icons
     */
    {
        _x params ["_unit", "_icon", "_color", "_name"];
        private _alpha = (player distance _unit) call _calc_alpha;
        private _pos = getPosVisual _unit;
        private _dir = getDirVisual _unit;
        _ctrl drawIcon [
            "iconMan",
            [0, 0, 0, _alpha],
            _pos,
            20,
            20,
            _dir,
            _name,
            0,
            0.03,
            "PuristaMedium",
            "right"
        ];
        _ctrl drawIcon [
            _icon,
            _color+[_alpha],
            _pos,
            16,
            16,
            _dir
        ];
    } forEach a3aa_map_trackers_units;
}];
