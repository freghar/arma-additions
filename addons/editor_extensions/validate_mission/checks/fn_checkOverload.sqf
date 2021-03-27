/*
 * check if any of the units are "overloaded" as in - whether their uniform,
 * vest or backpack contains more items than it should be able to hold
 * - this can happen after manual setUnitLoadout or out-of-game .sqm edit,
 *   replacing originally light items with heavy ones
 */

private _ents = [];
{
    if (loadUniform _x > 1 || loadVest _x > 1 || loadBackpack _x > 1) then {
        _ents pushBack _x;
    };
} forEach allUnits;

private _msg = [
    "Some units are overloaded (carry more than possible for their gear).",
    "This will result in players unable to pick up dropped items and maybe",
    "even being unable to run.",
    "This was caused either by a hand-edit to the loadout without the editor",
    "taking care to *not* overload the unit, or by a modset change that",
    "altered the weight of some items.",
    "Opening up vanilla (BI) arsenal on the overloaded unit and confirming",
    "via OK will remove the extra items. Alternatively, export and hand-edit",
    "the loadout using A3AA Loadout Copier or ACE Arsenal and import it back."
];

if (count _ents > 0) then {
    [["Overloaded units", false, _ents, _msg]];
} else {
    [["Overloaded units", true]];
};
