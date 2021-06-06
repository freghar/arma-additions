/*
 * a simplified version of balancePerFrame (no time guarantees) that is however
 * able to "pause" the iteration of items (repeat the call of second CODE with
 * the same item) when the second CODE returns a Boolean 'false'
 * - this allows one loop to last seconds/minutes without the time guarantee
 *   logic f*cking things up (executing all items in one frame) by trying to
 *   make up the difference towards expected completion time
 *
 * as with balancePerFrame, both CODEs can be given user arguments
 */

addMissionEventHandler [
    "EachFrame",
    {
        _thisArgs params ["_args", "_buff", "_idx"];
        _args params ["_init", "_process"];
        if (_idx < 0) then {
            /* refill buffer */
            _thisArgs set [1, _init call BIS_fnc_call];
            _thisArgs set [2, 0];
        } else {
            private ["_ret", "_next"];
            if (_process isEqualType []) then {
                _ret = [_buff select _i, _process select 0] call (_process select 1);
            } else {
                _ret = (_buff select _i) call _process;
            };
            if (!isNil "_ret" && {_ret isEqualTo false}) then {
                _next = _idx;
            } else {
                _next = if (_next >= count _buff) then { -1 } else { _idx + 1 };
            };
            _thisArgs set [2, _next];
        };
    },
    [
        _this,
        [],     /* buffer returned by _init, passed to _process */
        -1      /* current index into the buffer */
    ]
];
