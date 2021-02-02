_this params ["_unit", "_skills"];

{
    _unit setSkill [_x, _skills select _forEachIndex];
} forEach [
    "aimingAccuracy",
    "aimingShake",
    "aimingSpeed",
    "endurance",
    "spotDistance",
    "spotTime",
    "courage",
    "reloadSpeed",
    "commanding",
    "general"
];
