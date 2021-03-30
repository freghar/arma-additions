/*
 * check whether all units with a non-empty Persistent Callsign
 * have it set as their current Callsign
 */

private _grps = [];
{
    private _persistent = _x get3DENAttribute "a3aa_ee_persistent_callsign" select 0;
    if (!isNil "_persistent" && {_persistent isNotEqualTo ""}) then {
        if (groupId _x != _persistent) then {
            _grps pushBack _x;
        };
    };
} forEach allGroups;

private _msg = [
    "Some groups' current callsigns don't match persistent ones.",
    "Either you forgot to Tools -> A3AA -> Restore persistent Callsigns,",
    "or you have two groups with the same Persistent Callsign (in group",
    "attributes)."
];

if (count _grps > 0) then {
    [["Persistent callsigns", false, _grps, _msg]];
} else {
    [["Persistent callsigns", true]];
};
