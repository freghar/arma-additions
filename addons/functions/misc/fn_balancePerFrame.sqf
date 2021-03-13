/*
 * runs one CODE to pre-fill an array with items to be processed, one at
 * a time, by the second CODE, executed once per frame
 * when the array runs out of items, the first CODE is called again to re-fill
 * it with new items
 * - the idea is to spread the load of processing items in an array across
 *   frames, avoiding load spikes
 *
 * an optional third argument can specify the maximum approximated time
 * (in seconds) for all items in the list to be processed - if frames-per-second
 * are not enough to process all the array items within the specified time,
 * multiple calls of the second CODE will be made in one frame to make sure the
 * required time is met
 *
 * the array returned by the first CODE will be destroyed (elements removed),
 * so make sure to return a copy of it (using '+') if you need it preserved
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

[
    {
        (_this select 0) params ["_args", "_buff", "_endtime"];
        _args params ["_init", "_process", ["_maxtime", 100000]];
        if (_buff isEqualTo []) then {
            /* refill buffer */
            _buff = _init call BIS_fnc_call;
            (_this select 0) set [1, _buff];
            (_this select 0) set [2, diag_tickTime + _maxtime];
        } else {
            private _left = (_endtime - diag_tickTime) max 0;
            private _cnt = ceil (count _buff / ((diag_fps * _left) max 1));
            while { _cnt > 0 && _buff isNotEqualTo [] } do {
                /* pop last, O(1) */
                private _item = _buff deleteAt (count _buff - 1);
                _item call _process;
                _cnt = _cnt - 1;
            };
        };
    },
    0,
    [
        _this,
        [],     /* buffer returned by _init, passed to _process */
        0       /* diag_tickTime by which the buffer needs to be processed */
    ]
] call CBA_fnc_addPerFrameHandler;


#ifdef use_after_arma_v2.03
addMissionEventHandler [
    "EachFrame",
    {
        _thisArgs params ["_args", "_buff", "_endtime"];
        _args params ["_init", "_process", ["_maxtime", 100000]];
        if (_buff isEqualTo []) then {
            /* refill buffer */
            _buff = _init call BIS_fnc_call;
            _thisArgs set [1, _buff];
            _thisArgs set [2, diag_tickTime + _maxtime];
        } else {
            private _left = (_endtime - diag_tickTime) max 0;
            private _cnt = ceil (count _buff / ((diag_fps * _left) max 1));
            while { _cnt > 0 && _buff isNotEqualTo [] } do {
                /* pop last, O(1) */
                private _item = _buff deleteAt (count _buff - 1);
                _item call _process;
                _cnt = _cnt - 1;
            };
        };
    },
    [
        _this,
        [],     /* buffer returned by _init, passed to _process */
        0       /* diag_tickTime by which the buffer needs to be processed */
    ]
];
#endif
