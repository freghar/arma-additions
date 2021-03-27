/*
 * check for any unique ACRE radio classnames (ie. "ACRE_PRC343_ID_1")
 * - the units should have only generic ones, ie. "ACRE_PRC343"
 */

private _ents = [];
{
    private _unit = _x;
    {
        if (_x find "ACRE" == 0 && _x find "_ID_" != -1) exitWith {
            _ents pushBack _unit;
        };
    } forEach items _unit;
} forEach allUnits;

private _msg = [
    "Some units have unique radios containing _ID_ strings.",
    "This can happen as a result of saving an arsenal loadout mid-game",
    "and loading it in the editor later on.",
    "Fix it by exporting the loadout to a text editor, remove the _ID_123",
    "suffix from ie. ACRE_PRC343_ID_123 and import the loadout.",
    "Alternatively, save+load it via A3AA Loadout Copier which automatically",
    "replaces unique ACRE2 radios with generic ones."
];

if (count _ents > 0) then {
    [["Unique ACRE _ID_ radios", false, _ents, _msg]];
} else {
    [["Unique ACRE _ID_ radios", true]];
};
