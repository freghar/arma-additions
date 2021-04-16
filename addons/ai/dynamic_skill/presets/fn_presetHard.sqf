params ["_unit", "_current_skills"];

private [
    "_aimingAccuracy",
    "_aimingShake",
    "_aimingSpeed",
    "_endurance",
    "_spotDistance",
    "_spotTime",
    "_courage",
    "_reloadSpeed",
    "_commanding",
    "_general"
];


/*
 * make infantry fairly accurate, vehicles more so
 * (avoid >=0.9 for vehicles as it makes them single-shoot MGs)
 */
private _veh = vehicle _unit;
if (_veh != _unit && {_unit in [driver _veh, gunner _veh, commander _veh]}) then {
    if (_veh isKindOf "Tank" || _veh isKindOf "Air") then {
        _aimingAccuracy = 0.5;
    } else {
        /* Car and Ship */
        _aimingAccuracy = 0.4;
    };
} else {
    _aimingAccuracy = 0.5;
};

/*
 * give slight Parkinson's to guerrilla factions when shooting
 */
if (_unit call a3aa_ai_dynamic_skill_fnc_isGuerrilla) then {
    _aimingShake = 0.4;
    _aimingSpeed = 0.4;
} else {
    _aimingShake = 0.9;  /* 1.0 seems to do unnatural insta-headshot-kills */
    _aimingSpeed = 0.95;
};

_endurance = 1.0;
_spotDistance = 1.0;

/*
 * react slower to visual contact outside combat
 * (allow enemies to ie. reposition between trees, don't spot them instantly
 *  as they leave hard cover)
 */
_spotTime = switch (behaviour _unit) do {
    case "STEALTH";
    case "AWARE":  { 0.4 };
    case "COMBAT": { 0.95 };
    default { 0.2 };
};

_courage = 0.6;   /* allows retreat when under fire */
_reloadSpeed = 1.0;
_commanding = 1.0;
_general = 1.0;


[
    _aimingAccuracy, _aimingShake, _aimingSpeed, _endurance, _spotDistance,
    _spotTime, _courage, _reloadSpeed, _commanding, _general
];
