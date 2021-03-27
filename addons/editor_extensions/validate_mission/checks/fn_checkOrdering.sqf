/*
 * check if logic 3DEN entities don't precede non-logic ones
 * - this can happen if ie. HC or Virtual Spectator are placed before other
 *   playable units, or if the playable units are deleted and placed again
 */

private ["_i", "_ent", "_fail"];

/* entity IDs have gaps and there's no way to get the highest one, so guess */
for "_i" from 0 to 10000 do {
    _ent = get3DENEntity _i;
    if (!isNil "_ent" && {_ent isEqualType objNull} &&
            {(_ent get3DENAttribute "ControlSP") isEqualTo [true] ||
             (_ent get3DENAttribute "ControlMP") isEqualTo [true]}) exitWith {
        /* fail if logic, because we expect Playable non-logic first */
        if (_ent in (all3DENEntities select 3)) then { _fail = _ent };
    };
};

private _msg = [
    "Virtual entities were placed before actual playable soldiers.",
    "This can happen if you place Virtual Spectator / Headless Client logic",
    "entities or modules *before* you place playable soldiers, resulting in",
    "default MP lobby page being Virtual, not BLUFOR/OPFOR/Independent.",
    "Fix it by cut-pasting (ctrl-x, ctrl-v) the virtual units, so they're",
    "last again in the global ordering of units."
];

if (isNil "_fail") then {
    [["Playable unit ordering", true]];
} else {
    [["Playable unit ordering", false, [_ent], _msg]];
};
