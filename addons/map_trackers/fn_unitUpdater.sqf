/*
 * at regular intervals, collect units in range, process them and feed them
 * to the Draw EH
 */

/* wait for all units of the player's group to initialize */
waitUntil { !isNil "BIS_fnc_init" };
waitUntil { !isNull player };

private _get_units = {
    switch (a3aa_map_trackers_unit_status) do {
        case "group": {
            units group player;
        };
        case "side": {
            private _player_side = side player;
            allPlayers select { side _x == _player_side };
        };
        case "allies": {
            private _player_side = side player;
            allPlayers select { side _x getFriend _player_side >= 0.6 };
        };
        case "all": {
            allPlayers;
        };
        default { [] };
    };
};

private _is_medic = {
    _this getUnitTrait "medic"
    && {
        !(_this getUnitTrait "engineer")
        && !(_this getUnitTrait "explosiveSpecialist")
    }
};
private _is_engi = {
    _this getUnitTrait "engineer" && !(_this getUnitTrait "medic")
};

private _get_icon = {
    switch (a3aa_map_trackers_unit_iconsource) do {
        case "class": {
            private _icon = getText (
                configFile >> "CfgVehicles" >> typeOf _this >> "icon"
            );
            if (_icon == "") then { "iconMan" } else { _icon };
        };
        case "guess": {
            private _mags = getArray (configFile >> "CfgWeapons" >> primaryWeapon _this >> "magazines");
            private _bulletcnt = if (!(_mags isEqualTo [])) then {
                getNumber (configFile >> "CfgMagazines" >> (_mags select 0) >> "count");
            } else {};
            switch true do {
                case (leader group _this == _this): { "iconManLeader" };
                case (_this call _is_medic): { "iconManMedic" };
                case (_this call _is_engi): { "iconManEngineer" };
                case (secondaryWeapon _this != ""): { "iconManAT" };
                case (!isNil "_bulletcnt" && {_bulletcnt >= 50}): { "iconManMG" };
                default { "iconMan" };
            };
        };
        default {
            "iconMan";
        };
    };
};

private _get_color = {
    switch (assignedTeam _this) do {
        case "RED":    { [1, 0.2, 0.2] };
        case "GREEN":  { [0.2, 1, 0.2] };
        case "BLUE":   { [0.4, 0.4, 1] };
        case "YELLOW": { [0.7, 0.7, 0] };
        default        { [0.9, 0.9, 0.9] };
    };
};

waitUntil {
    /* allow smooth fade-in @ soldier move speed (see Draw EH) */
    private _dist = a3aa_map_trackers_unit_dist + 20;

    /*
     * soldier icons
     */
    private _units = ([] call _get_units) select {
        !isNull _x && {player distance _x < _dist};
    };
    private _grp_units = units group player;
    _units = _units apply {
        /* [object, icon, color, name] */
        [
            _x,
            _x call _get_icon,
            _x call _get_color,
            if (a3aa_map_trackers_unit_shownames) then { name _x } else { "" }
        ];
    };

    /*
     * blue lines
     */
    private _lines = [];
    if (a3aa_map_trackers_unit_showlines && !(_units isEqualTo [])) then {
        private _leader = leader group player;
        private _sources = (units group player) select {
            _x != _leader && {player distance _x < _dist};
        };
        _lines = _sources apply {
            /* [src, dst] */
            [_x, _leader];
        };
    };

    a3aa_map_trackers_units = _units;
    a3aa_map_trackers_unit_lines = _lines;

    /* because of a briefing map screen */
    uiSleep 1;
    false;
}
