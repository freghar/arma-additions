private _get_nato_color = {
    /* from profile, probably for colorblind settings */
    private _idx = switch (_this) do {
        case "blue": {
            [
                ["Map_BLUFOR_R", 0],
                ["Map_BLUFOR_G", 0.3],
                ["Map_BLUFOR_B", 0.6],
                ["Map_BLUFOR_A", 1]
            ]
        };
        case "green": {
            [
                ["Map_Independent_R", 0],
                ["Map_Independent_G", 0.5],
                ["Map_Independent_B", 0],
                ["Map_Independent_A", 1]
            ]
        };
        case "red": {
            [
                ["Map_OPFOR_R", 0.5],
                ["Map_OPFOR_G", 0],
                ["Map_OPFOR_B", 0],
                ["Map_OPFOR_A", 1]
            ]
        };
    };
    _idx apply {
        profilenamespace getvariable _x;
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

private _group_type = {
    params ["_grp"];
    private _type = nil;

    /* set by mission */
    _type = _grp getVariable "a3aa_map_trackers_group_type";
    if (!isNil "_type") exitWith { _type };

    /*
     * prio: 1
     * mechanized inf / armor / anti-air / helicopter / plane / artillery  / uav
     */
    private _units = units _grp;
    private _leader = leader _grp;
    private _veh = vehicle _leader;
    private _crew = (fullCrew _veh) apply {
        /* crew without cargo and FFV */
        if (_x select 4) then { objNull } else { _x select 0 };
    };
    _type = if (!isNull objectParent _leader && _leader in _crew) then {
        private _cfg = configOf _veh;
        private _infotype = getText (_cfg >> "unitInfoType");
        private _vclass = getText (_cfg >> "vehicleClass");
        private _edcat = getText (_cfg >> "editorSubcategory");
        switch true do {
            case (_vclass == "Autonomous"):             { "uav" };  /* can be anything */
            case (_infotype == "RscUnitInfoArtillery"): { "art" };  /* can be Car */
            case (_veh isKindOf "Tank_F"): {
                switch true do {
                    case (_edcat == "EdSubcat_APCs" || _vclass in ["rhs_vehclass_apc","rhs_vehclass_ifv"]): { "mech_inf" };
                    case (_edcat == "EdSubcat_AAs" || _vclass == "rhs_vehclass_aa"): { "antiair" };
                    default { "armor" };
                };
            };
            case (_veh isKindOf "Wheeled_APC_F"):  { "mech_inf" };
            case (_veh isKindOf "Car"):            { "motor_inf" };
            case (_veh isKindOf "UAV"):            { "uav" };
            case (_veh isKindOf "Helicopter"):     { "air" };
            case (_veh isKindOf "Plane"):          { "plane" };
            case (_veh isKindOf "Ship"):           { "naval" };
            case (_veh isKindOf "StaticMortar"):   { "mortar" };
            case (_veh isKindOf "StaticAAWeapon"): { "antiair" };
            case (_veh isKindOf "StaticCannon"):   { "art" };
            default { "unknown" };
        };
    };
    if (!isNil "_type") exitWith { _type };

    /*
     * prio: 2
     * medic team / engineer team / etc.
     */
    private _unitshalf = count _units / 2;
    _type = switch true do {
        /* if >= half of the team is medic / engi, mark the team as such */
        case (({ _x call _is_medic } count _units) >= _unitshalf): {
            "med";
        };
        case (({ _x call _is_engi } count _units) >= _unitshalf): {
            "maint";
        };
        default {};
    };
    if (!isNil "_type") exitWith { _type };

    /*
     * prio: 3
     * infantry / recon
     */
    if (count _units <= 4) then {
        "recon";
    } else {
        "inf";
    };
};


params ["_group"];

private _grp_side = side _group;
private _player_side = side group player;
private _type = _group call _group_type;

/* %1: prefix ('b_', 'n_', 'o_') , %2: type ('inf', 'armor', etc.) */
private _icon_path = "\A3\ui_f\data\map\Markers\NATO\%1_%2.paa";

switch true do {
    case (_grp_side == _player_side): {
        [
            format [_icon_path, "b", _type],
            "blue" call _get_nato_color
        ];
    };
    case (_grp_side getFriend _player_side >= 0.6): {
        [
            format [_icon_path, "n", _type],
            "green" call _get_nato_color
        ];
    };
    default {
        [
            format [_icon_path, "o", _type],
            "red" call _get_nato_color
        ];
    };
};
