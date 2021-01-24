/*
 * run code and pass it either _default as [_default] or (if null)
 * display _select_msg and let the curator select units and pass them
 * as an array - this means the code will always receive an iterable
 * array of units
 *
 * optionally transform the unit selection into unique groups, etc.
 *
 * the _code can be either CODE or ARRAY of [custom arg, CODE] like
 * for 'call', the former receives just an array of units, the latter
 * gets [array of units, custom arg]
 *
 * _transform (optional) specifies how to modify the collected array
 * of units before passing it to _code:
 *   "groups": units into an array of their (deduplicated) groups
 *   "vehicles": units into Car,Air,Tank,Ship vehicles they inhabit
 */

params ["_default", "_select_msg", "_code", ["_transform",""]];

if (!isNull _default) then {
    [[_default], _code, _transform]
        call a3aa_ares_extras_fnc_selectUnitsSelected;
} else {
    [
        _select_msg,
        [
            [_code, _transform],
            {
                params ["_code", "_transform"];
                [curatorSelected select 0, _code, _transform]
                    call a3aa_ares_extras_fnc_selectUnitsSelected;
            }
        ]
    ] call a3aa_ares_extras_fnc_confirm;
};
