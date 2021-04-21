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


private _veh = vehicle _unit;
if (_veh != _unit && {_unit in [driver _veh, gunner _veh, commander _veh]}) then {
    if (_veh isKindOf "Tank" || _veh isKindOf "Air") then {
        _aimingAccuracy = 0.4;
    } else {
        /* Car and Ship */
        _aimingAccuracy = 0.3;
    };
} else {
    _aimingAccuracy = 0.3;
};

_aimingShake = 0.4;
_aimingSpeed = 0.25;
_endurance = 1.0;
_spotDistance = 0.7;

_spotTime = switch (behaviour _unit) do {
    case "STEALTH";
    case "AWARE":  { 0.4 };
    case "COMBAT": { 0.7 };
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
