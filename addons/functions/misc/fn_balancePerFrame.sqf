/*
 * runs one CODE to pre-fill an array with items to be processed, one at
 * a time, by the second CODE, executed once per frame
 * when the array runs out of items, the first CODE is called again to re-fill
 * it with new items
 * - the idea is to spread the load of processing items in an array across
 *   frames, avoiding load spikes
 *
 * an optional third argument can specify the maximum time (in seconds) for all
 * items in the list to be processed - if frames-per-second are not enough to
 * process all the array items within the specified time, multiple calls of the
 * second CODE will be made in one frame to make sure the required time is met
 *
 * either or both CODE blocks may be [arg, { ... }] in order to pass a custom
 * argument to them (like for BIS_fnc_call) - the first CODE block will receive
 * it simply as _this, the second block will get [array_item,arg] instead of
 * just array_item
 *
 * ie.
 * [
 *     // array-filling CODE, returns an array
 *     {
 *         allUnits;
 *     },
 *     // CODE processing one member of the array
 *     {
 *         if (!alive _this || isPlayer _this || !local _this) exitWith {};
 *         if (behaviour _this == "COMBAT") then {
 *             if (skill _this != 0.8) then {
 *                 _this setSkill 0.8;
 *             };
 *         } else {
 *             if (skill _this != 0.5) then {
 *                 _this setSkill 0.5;
 *             };
 *         };
 *     },
 *     // always process all units within 15 seconds
 *     15
 * ] call a3aa_fnc_balancePerFrame;
 */

addMissionEventHandler [
    "EachFrame",
    {
        _thisArgs params ["_args", "_buff", "_idx", "_endtime"];
        _args params ["_init", "_process", ["_maxtime", 100000]];
        if (_idx < 0) then {
            /* refill buffer */
            _thisArgs set [1, _init call BIS_fnc_call];
            _thisArgs set [2, 0];
            _thisArgs set [3, diag_tickTime + _maxtime];
        } else {
            private _time_left = (_endtime - diag_tickTime) max 0;
            private _items_left = count _buff - _idx;
            private _next = _idx + ceil (_items_left / ((diag_fps * _time_left) max 1));
            for "_i" from _idx to (_next - 1) do {
                if (_process isEqualType []) then {
                    [_buff select _i, _process select 0] call (_process select 1);
                } else {
                    (_buff select _i) call _process;
                };
            };
            if (_next >= count _buff) then { _next = -1 };
            _thisArgs set [2, _next];
        };
    },
    [
        _this,
        [],     /* buffer returned by _init, passed to _process */
        -1,     /* current index into the buffer */
        0       /* diag_tickTime by which the buffer needs to be processed */
    ]
];
