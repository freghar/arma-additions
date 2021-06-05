if (is3DEN || !isDedicated) exitWith {};

/*
 * do continuous searching for groups to transfer, don't rely just on init EH
 * - when a HC disconnects, its groups would go to the server and remain there
 *   forever, same for remote control in case it doesn't return the group back
 */

private _wait_between = _this getVariable "a3aa_ee_locality_transfer_wait_between";
private _spawn_delay = _this getVariable "a3aa_ee_locality_transfer_delay_after_spawn";
private _distribute = _this getVariable "a3aa_ee_locality_transfer_distribute";
private _fallback = _this getVariable "a3aa_ee_locality_transfer_server_fallback";
private _statistics = _this getVariable "a3aa_ee_locality_transfer_statistics";

if (_statistics) then {
    [] spawn a3aa_ee_locality_transfer_fnc_statisticsLoop;
};

a3aa_ee_locality_transfer_hcdata = createHashMap;

0 = [_wait_between, _spawn_delay, _distribute, _fallback] spawn {
    params ["_wait_between", "_spawn_delay", "_distribute", "_fallback"];

    /* give other scripts a chance to run AL EG commands */
    sleep 3;

    private _state = createHashMap;
    _state set ["op", "transfer"];
    [
        {
            allGroups;
        },
        [[_wait_between, _spawn_delay, _distribute, _fallback, _state], {
            params ["_grp", "_args"];
            _args params ["_wait_between", "_spawn_delay", "_distribute", "_fallback", "_state"];

            switch (_state get "op") do {
                /*
                 * wait after setGroupOwner for the owner to change
                 */
                case "owner_change": {
                    private _oldowner = _state get "oldowner";
                    private _endtime = _state get "endtime";
                    if (groupOwner _grp != _oldowner || diag_tickTime > _endtime) then {
                        /* wait after transfer */
                        _state set ["endtime", diag_tickTime + _wait_between];
                        _state set ["op", "delay"];
                    };
                    false;
                };
                /*
                 * delay after confirmed owner_change
                 */
                case "delay": {
                    private _endtime = _state get "endtime";
                    if (diag_tickTime > _endtime) then {
                        _state set ["op", "transfer"];
                        nil;  /* next grp */
                    } else {
                        false;
                    };
                };
                /*
                 * the main course - do group transfer
                 */
                case "transfer": {
                    private _hcs = [] call a3aa_ee_locality_transfer_fnc_getAllHCs;
                    /* before game start (HCs still connecting) or new HC just connected */
                    if (!(_hcs call a3aa_ee_locality_transfer_fnc_areHCsReady)) exitWith {
                        false;
                    };

                    /* if it fails basic sanity checks, abort */
                    if (isNull _grp) exitWith {};
                    private _units = units _grp;
                    if (_units isEqualTo []) exitWith {};
                    if (_units findIf { isPlayer _x } != -1) exitWith {};
                    if (_grp getVariable ["a3aa_ee_locality_transfer_exclude", false]) exitWith {};

                    /* if we haven't seen it before or if it's too soon, abort */
                    private _spawn_delay_end =
                        _grp getVariable "a3aa_ee_locality_transfer_spawn_delay_end";
                    if (isNil "_spawn_delay_end") exitWith {
                        _grp setVariable [
                            "a3aa_ee_locality_transfer_spawn_delay_end",
                            diag_tickTime + _spawn_delay
                        ];
                    };
                    if (_spawn_delay_end > diag_tickTime) exitWith {};

                    /* if there's Curator remote controlling any unit in the grp, abort */
                    if (_units findIf {
                            private _rc = _x getVariable "bis_fnc_moduleremotecontrol_owner";
                            !isNil "_rc";
                        } != -1) exitWith {};

                    /* if we have >1 HCs and the group is not on a HC, move it & wait */
                    if (_hcs isNotEqualTo []) exitWith {
                        if (groupOwner _grp in _hcs) exitWith {};  /* next! */
                        private _dst = [_distribute, _hcs]
                            call a3aa_ee_locality_transfer_fnc_getSuitableHC;
                        _state set ["oldowner", groupOwner _grp];
                        _grp setGroupOwner _dst;
                        _state set ["endtime", diag_tickTime + 30];  /* safety */
                        _state set ["op", "owner_change"];
                        false;
                    };

                    /* else if we can fallback to server, do so */
                    if (_fallback && groupOwner _grp > 2) exitWith {
                        _state set ["oldowner", groupOwner _grp];
                        _grp setGroupOwner 2;
                        _state set ["endtime", diag_tickTime + 30];  /* safety */
                        _state set ["op", "owner_change"];
                        false;
                    };

                    /* else do nothing with the group */
                };
            };
        }]
    ] call a3aa_fnc_balancePerFrameCondition;
};

/* tell HCs to start sending their data to the server */
remoteExec ["a3aa_ee_locality_transfer_fnc_updateHCInfo", -2, true];

deleteVehicle _this;
