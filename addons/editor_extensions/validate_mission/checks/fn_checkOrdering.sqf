/*
 * check if logic 3DEN entities don't precede non-logic ones
 * - this can happen if ie. HC or Virtual Spectator are placed before other
 *   playable units, or if the playable units are deleted and placed again
 */

private _pass = {
    [["Playable unit ordering", true]];
};

private _units = playableUnits;
private _systems = units sideLogic;

/* player can, but might not be part of playableUnits */
if (!isNull player) then {
    if (side player == sideLogic) then {
        _systems pushBackUnique player;
    } else {
        _units pushBackUnique player;
    };
};

if (_units isEqualTo [] || _systems isEqualTo []) exitWith _pass;

private _unit_id = selectMin ((_units apply { get3DENEntityId _x }) - [-1]);
if (isNil "_unit_id") exitWith _pass;

private _systems_playable = _systems select {
    (_x get3DENAttribute "ControlMP") isEqualTo [true]
};
if (_systems_playable isEqualTo []) exitWith _pass;

private _system_id = selectMin ((_systems_playable apply { get3DENEntityId _x }) - [-1]);

if (_unit_id > _system_id) then {
    [["Playable unit ordering", false, [_ent], [
        "Virtual entities were placed before actual playable soldiers.",
        "This can happen if you place Virtual Spectator / Headless Client logic",
        "entities or modules *before* you place playable soldiers, resulting in",
        "default MP lobby page being Virtual, not BLUFOR/OPFOR/Independent.",
        "Fix it by cut-pasting (ctrl-x, ctrl-v) the virtual units, so they're",
        "last again in the global ordering of units."
    ]]];
} else {
    [] call _pass;
};
