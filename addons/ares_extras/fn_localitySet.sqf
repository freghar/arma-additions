/*
 * this doesn't rely on get/setUnitLoadout like CBA/ACEX/ZEN
 * - instead, it transfers groups *really* slowly and hopes that
 *   it won't hit the naked unit issue even on a loaded server
 */

/*
 * needs to be spawn-ed on the server, ie. via remoteExec which
 * executes functions in scheduled env
 */

params ["_target", "_groups"];

if (!isNil "a3aa_ares_extras_transferring_units") exitWith {
    "Locality transfer already running."
        remoteExec ["systemChat", remoteExecutedOwner];
};
a3aa_ares_extras_transferring_units = true;

if (_target isEqualTo -1) then {
    _target = 2;  /* special value for Server */
} else {
    _target = owner _target;  /* passed unit */
};

_groups = _groups select { groupOwner _x != _target };

private _i = 0;
private _total = count _groups;
format ["Going to transfer %1 groups.", _total]
    remoteExec ["systemChat", remoteExecutedOwner];
{
    if (!isNull _x) then {
        private _src = groupOwner _x;
        _x setGroupOwner _target;
        waitUntil {
            !(_src in (units _x apply { owner _x }));
        };
        _i = _i + 1;
        if (_i < _total) then { sleep 10 };
        format ["%1 done (%2/%3)", str _x, _i, _total]
            remoteExec ["systemChat", remoteExecutedOwner];
    };
} forEach _groups;

"Locality transfer done."
    remoteExec ["systemChat", remoteExecutedOwner];

a3aa_ares_extras_transferring_units = nil;
