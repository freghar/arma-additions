/*
 * register custom modules/functions in Zeus Enhanced (ZEN)
 */

if (isNil "zen_custom_modules_fnc_register") exitWith {};

[
    "A3AA",
    "Forget enemies",
    {
        ["Select units.", {
            private _units = curatorSelected select 0;
            if (_units isEqualTo []) exitWith {
                ["No units selected.", "cancel"]
                    call a3aa_ares_extras_fnc_curatorMsg;
            };
            {
                [_x, {
                    { _this forgetTarget _x } forEach (_this targets [true]);
                }] remoteExec ["call", _x];
            } forEach _units;
        }] call a3aa_ares_extras_fnc_confirm;
    }
] call zen_custom_modules_fnc_register;

[
    "A3AA",
    "Reveal enemies",
    {
        ["Select to-be-revealed units.", {
            private _revealed = curatorSelected select 0;
            if (_revealed isEqualTo []) exitWith {
                ["No units selected.", "cancel"]
                    call a3aa_ares_extras_fnc_curatorMsg;
            };
            ["Select groups that should be informed.", [_revealed, {
                private _revealed = _this;
                private _informed_units = curatorSelected select 0;
                private _informed = [];
                {
                    _informed pushBackUnique group _x;
                } forEach (_informed_units select { alive _x });
                if (_informed isEqualTo []) exitWith {
                    ["No groups with alive units selected.", "cancel"]
                        call a3aa_ares_extras_fnc_curatorMsg;
                };
                [
                    [_revealed, _informed],
                    {
                        params ["_revealed", "_informed"];
                        {
                            private _toinform = _x;
                            {
                                _toinform reveal _x;
                            } forEach _revealed;
                        } forEach _informed;
                    }
                ] remoteExec ["call"];  /* reveal has local effect, see wiki */
            }]] call a3aa_ares_extras_fnc_confirm;
        }] call a3aa_ares_extras_fnc_confirm;
    }
] call zen_custom_modules_fnc_register;

[
    "A3AA",
    "Watch",
    {
        params ["_pos", "_unit"];
        private _dst = _unit;
        if (isNil "_unit" || isNull _unit) then {
            _dst = _pos;  /* use pos as dst */
        };
        ["Select watcher units.", [_dst, {
            private _dst = _this;
            private _units = curatorSelected select 0;
            if (_units isEqualTo []) exitWith {
                ["No units selected.", "cancel"]
                    call a3aa_ares_extras_fnc_curatorMsg;
            };
            {
                [[_x, _dst], {
                    params ["_unit", "_dst"];
                    _unit doWatch _dst;
                }] remoteExec ["call", _x];
            } forEach _units;
        }]] call a3aa_ares_extras_fnc_confirm;
    }
] call zen_custom_modules_fnc_register;

[
    "A3AA",
    "No unload in combat",
    {
        ["Select vehicles.", {
            private _units = curatorSelected select 0;
            _units = _units select {
                _x isKindOf "Tank" || _x isKindOf "Car" || _x isKindOf "Ship";
            };
            if (_units isEqualTo []) exitWith {
                ["No vehicles selected.", "cancel"]
                    call a3aa_ares_extras_fnc_curatorMsg;
            };
            {
                [_x, false, false] remoteExec ["setUnloadInCombat", _x];
            } forEach _units;
        }] call a3aa_ares_extras_fnc_confirm;
    }
] call zen_custom_modules_fnc_register;

[
    "A3AA",
    "Flee",
    {
        ["Select groups.", {
            private _units = curatorSelected select 0;
            private _groups = [];
            { _groups pushBackUnique group _x } forEach _units;
            if (_groups isEqualTo []) exitWith {
                ["No groups selected.", "cancel"]
                    call a3aa_ares_extras_fnc_curatorMsg;
            };
            {
                [_x, {
                    private _isfleeing = _this getVariable "a3aa_ares_extras_fleeing";
                    if (isNil "_isfleeing") then {
                        {
                            _x setUnitPos "UP";
                            _x disableAI "AUTOCOMBAT";
                            _x disableAI "AUTOTARGET";
                            _x disableAI "TARGET";
                            _x disableAI "SUPPRESSION";
                            {
                                _this forgetTarget _x;
                            } forEach (_x targets []);
                        } forEach units _this;
                        _this setBehaviour "AWARE";
                        _this setSpeedMode "FULL";
                        _this spawn {
                            sleep 120;
                            {
                                _x enableAI "AUTOCOMBAT";
                                _x enableAI "AUTOTARGET";
                                _x enableAI "TARGET";
                                _x enableAI "SUPPRESSION";
                            } forEach units _this;
                            _this setVariable ["a3aa_ares_extras_fleeing", nil, true];
                        };
                        _this setVariable ["a3aa_ares_extras_fleeing", true, true];
                    };
                }] remoteExec ["call", leader _x];
            } forEach _groups;
        }] call a3aa_ares_extras_fnc_confirm;
    }
] call zen_custom_modules_fnc_register;

[
    "A3AA",
    "Suppress (bis)",
    {
        params ["_pos", "_unit"];
        private _dst = _unit;
        if (isNil "_unit" || isNull _unit) then {
            _dst = _pos;  /* use pos as dst */
        };
        ["Select sources (soldiers/vehicles).", [_dst, {
            private _dst = _this;
            private _units = curatorSelected select 0;
            if (_units isEqualTo []) exitWith {
                ["No units selected.", "cancel"]
                    call a3aa_ares_extras_fnc_curatorMsg;
            };
            /* doSuppressiveFire doesn't work well on position */
            if (!(_dst isEqualType objNull)) then {
                _dst = createVehicle ["Land_HelipadEmpty_F", ASLToATL _dst,
                                      [], 0, "CAN_COLLIDE"];
                0 = _dst spawn { sleep 30; deleteVehicle _this; };
            };
            {
                [[_x, _dst], {
                    params ["_src", "_dst"];
                    _src reveal _dst;
                    _src doSuppressiveFire _dst;
                }] remoteExec ["call", _x];
            } forEach _units;
        }]] call a3aa_ares_extras_fnc_confirm;
    }
] call zen_custom_modules_fnc_register;

[
    "A3AA",
    "Assign Task Force",
    {
        ["Select TF member groups.", {
            private _units = curatorSelected select 0;
            private _groups = [];
            { _groups pushBackUnique group _x } forEach _units;
            if (_groups isEqualTo []) exitWith {
                ["No groups selected.", "cancel"]
                    call a3aa_ares_extras_fnc_curatorMsg;
            };
            if (count _groups < 1) exitWith {};
            _groups call a3aa_ares_extras_fnc_assignTaskForce;
        }] call a3aa_ares_extras_fnc_confirm;
    }
] call zen_custom_modules_fnc_register;

[
    "A3AA",
    "Force WP Setting",
    {
        ["Select groups.", {
            private _units = curatorSelected select 0;
            private _groups = [];
            { _groups pushBackUnique group _x } forEach _units;
            if (_groups isEqualTo []) exitWith {
                ["No groups selected.", "cancel"]
                    call a3aa_ares_extras_fnc_curatorMsg;
            };
            if (count _groups < 1) exitWith {};
            [_groups, {
                {
                    {
                        _x setWaypointForceBehaviour true;
                        _x setWaypointBehaviour "AWARE";
                    } forEach waypoints _x;
                } forEach _this;
            }] remoteExec ["call", 2];
        }] call a3aa_ares_extras_fnc_confirm;
    }
] call zen_custom_modules_fnc_register;

[
    "A3AA",
    "No Talking",
    {
        ["Select units.", {
            private _units = curatorSelected select 0;
            if (_units isEqualTo []) exitWith {
                ["No units selected.", "cancel"]
                    call a3aa_ares_extras_fnc_curatorMsg;
            };
            {
                [_x, "NoVoice"] remoteExec ["setSpeaker", 0, _x];
            } forEach _units;
        }] call a3aa_ares_extras_fnc_confirm;
    }
] call zen_custom_modules_fnc_register;

#ifdef not_ported_over_yet
[
    "Development Tools",
    "[U] Locality - Get",
    {
        params ["_pos", "_unit"];
        if (isNull _unit) exitWith {};
        [_unit, {
            format ["%1 local to %2", _this, owner _this]
                remoteExec ["systemChat", remoteExecutedOwner];
        }] remoteExec ["call", 2];
    }
] call zen_custom_modules_fnc_register;
[
    "Development Tools",
    "[G] Locality - Set",
    {
        if (!isMultiplayer) exitWith {
            ["Not applicable in singleplayer."] call Ares_fnc_ShowZeusMessage;
        };

        private _hcs = (entities "HeadlessClient_F") select { _x in allPlayers };
        private _targets =
            _hcs +
            [-1] +
            (allPlayers - _hcs);
        private _target_names =
            (_hcs apply { name _x }) +
            ["Server"] +
            ((allPlayers - _hcs) apply { name _x });

        private _reply = [
            "Set locality / owner of groups",
            [
                ["Choose new owner", _target_names]
            ]
        ] call Ares_fnc_showChooseDialog;
        if (_reply isEqualTo []) exitWith {};
        private _target = _targets select (_reply select 0);

        private _units = [_this select 1];
        if (objNull in _units) then {
            _units = ["groups to transfer"] call Achilles_fnc_SelectUnits;
        };
        if (isNil "_units") exitWith {};
        private _groups = [];
        { _groups pushBackUnique group _x } forEach _units;

        [[_target, _groups], {
            params ["_target", "_groups"];

            if (!isNil "a3aa_ares_extras_transferring_units") exitWith {
                "Locality transfer already running." remoteExec ["systemChat", remoteExecutedOwner];
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
            format ["Going to transfer %1 groups.", _total] remoteExec ["systemChat", remoteExecutedOwner];
            {
                if (!isNull _x) then {
                    private _src = groupOwner _x;
                    _x setGroupOwner _target;
                    waitUntil {
                        !(_src in (units _x apply { owner _x }));
                    };
                    _i = _i + 1;
                    sleep 10;
                    format ["%1 done (%2/%3)", str _x, _i, _total] remoteExec ["systemChat", remoteExecutedOwner];
                };
            } forEach _groups;
            a3aa_ares_extras_transferring_units = nil;
            "Locality transfer done." remoteExec ["systemChat", remoteExecutedOwner];
        }] remoteExec ["spawn", 2];
    }
] call zen_custom_modules_fnc_register;
#endif

#ifdef not_ported_over_yet
[
    "Development Tools",
    "Give Zeus to player (may crash)",
    {
        params ["_pos", "_unit"];
        if (isNil "_unit" || isNull _unit) exitWith {
            ["No unit selected."] call Ares_fnc_ShowZeusMessage;
        };
        if (!isNull getAssignedCuratorLogic _unit) exitWith {
            ["Player already has Zeus."] call Ares_fnc_ShowZeusMessage;
        };
        [_unit, {
            if (!isNull getAssignedCuratorLogic _this) exitWith {};
            private _curator = ([_this, false] call insta_zeus_fnc_mkCurator);
            0 = [_curator, _this] spawn {
                params ["_curator", "_unit"];
                waitUntil {
                    _unit assignCurator _curator;
                    !isNull getAssignedCuratorUnit _curator;
                };
            };
        }] remoteExec ["call", 2];
    }
] call Ares_fnc_RegisterCustomModule;
#endif

[
    "A3AA",
    "Terrain Objects Hide/Show",
    {
        params ["_pos", "_unit"];
        [
            "Hide/Show Terrain Objects",
            [
                ["LIST", "Within radius of", [
                    [1,5,10,100,500,1000,5000],
                    ["1m","5m","10m","100m","500m","1000m","5000m"],
                    2,
                    8
                ]],
                ["EDIT:CODE", ["Object types", '"tree","small tree","bush","building","house",etc.\nsee BI wiki for nearestTerainObjects'], ["[]", {}, 1]],
                ["CHECKBOX", "Hide (uncheck to show)", [true]]
            ],
            {
                params ["_dialog_data", "_pos"];
                _dialog_data params ["_radius", "_types", "_hide"];
                _types = parseSimpleArray _types;
                [[_pos, _radius, _types, _hide], {
                    params ["_pos", "_radius", "_types", "_hide"];
                    {
                        _x hideObjectGlobal _hide;
                    } count nearestTerrainObjects [_pos, _types, _radius, false, true];
                }] remoteExec ["call", 2];
            },
            nil,
            _pos
        ] call zen_dialog_fnc_create;
    }
] call zen_custom_modules_fnc_register;

#ifdef not_ported_over_yet
[
    "Players",
    "Set new player unit",
    {
        params ["_pos", "_unit"];
        if (isNil "_unit" || isNull _unit) exitWith {
            ["No unit selected."] call Ares_fnc_ShowZeusMessage;
        };
        if (!(_unit isKindOf "CAManBase")) exitWith {
            ["Unit is not a soldier."] call Ares_fnc_ShowZeusMessage;
        };

        a3aa_ares_extras_collected_clients = [];
        {
            [[clientOwner, profileName], {
                a3aa_ares_extras_collected_clients pushBack _this;
            }] remoteExec ["call", remoteExecutedOwner];
        } remoteExec ["call"];
        sleep 1;
        a3aa_ares_extras_collected_clients sort true;

        private _clients = a3aa_ares_extras_collected_clients apply { _x select 0 };
        private _names = a3aa_ares_extras_collected_clients apply { _x select 1 };
        private _reply = [
            "Set new player unit",
            [
                ["Choose client", _names]
            ]
        ] call Ares_fnc_showChooseDialog;
        if (_reply isEqualTo []) exitWith {};
        private _client = _clients select (_reply select 0);

        _unit remoteExec ["selectPlayer", _client];
    }
] call Ares_fnc_RegisterCustomModule;
#endif

[
    "A3AA",
    "End Mission - Won",
    {
        { ["stop", cntr_exportPath] call cntr_fnc_export } remoteExecCall ["call", 2];
        ["end1", true] remoteExec ["BIS_fnc_endMission"];
    }
] call zen_custom_modules_fnc_register;
[
    "A3AA",
    "End Mission - Lost",
    {
        { ["stop", cntr_exportPath] call cntr_fnc_export } remoteExecCall ["call", 2];
        ["end1", false] remoteExec ["BIS_fnc_endMission"];
    }
] call zen_custom_modules_fnc_register;

[
    "A3AA",
    "Move respawn",
    {
        params ["_pos", "_unit"];
        if ({ _x find "respawn" == 0 } count allMapMarkers < 1) then {
            createMarker ["respawn", _pos];
        } else {
            "respawn" setMarkerPos _pos;
        };
    }
] call zen_custom_modules_fnc_register;
[
    "A3AA",
    "Move respawn_west",
    {
        params ["_pos", "_unit"];
        if ({ _x find "respawn" == 0 } count allMapMarkers < 1) then {
            createMarker ["respawn_west", _pos];
        } else {
            "respawn_west" setMarkerPos _pos;
        };
    }
] call zen_custom_modules_fnc_register;
[
    "A3AA",
    "Move respawn_east",
    {
        params ["_pos", "_unit"];
        if ({ _x find "respawn" == 0 } count allMapMarkers < 1) then {
            createMarker ["respawn_east", _pos];
        } else {
            "respawn_east" setMarkerPos _pos;
        };
    }
] call zen_custom_modules_fnc_register;
[
    "A3AA",
    "Move respawn_guerrila",
    {
        params ["_pos", "_unit"];
        if ({ _x find "respawn" == 0 } count allMapMarkers < 1) then {
            createMarker ["respawn_guerrila", _pos];
        } else {
            "respawn_guerrila" setMarkerPos _pos;
            "respawn_guerilla" setMarkerPos _pos;
            "respawn_guerrilla" setMarkerPos _pos;
        };
    }
] call zen_custom_modules_fnc_register;
[
    "A3AA",
    "Move respawn_civilian",
    {
        params ["_pos", "_unit"];
        if ({ _x find "respawn" == 0 } count allMapMarkers < 1) then {
            createMarker ["respawn_civilian", _pos];
        } else {
            "respawn_civilian" setMarkerPos _pos;
        };
    }
] call zen_custom_modules_fnc_register;

[
    "A3AA",
    "Move JIP teleport point",
    {
        params ["_pos", "_unit"];
        _pos = ATLToASL _pos;
        /* spawn the module if it wasn't placed in the editor */
        if (isNil "a3aa_ee_teleport_on_jip_pos") then {
            if (isClass (configFile >> "CfgVehicles" >> "a3aa_ee_teleport_on_jip")) then {
                (createGroup sideLogic) createUnit ["a3aa_ee_teleport_on_jip", _pos, [], 0, "CAN_COLLIDE"];
            };
        } else {
            a3aa_ee_teleport_on_jip_pos = _pos;
            publicVariable "a3aa_ee_teleport_on_jip_pos";
        };
    }
] call zen_custom_modules_fnc_register;

[
    "A3AA",
    "Delete units (really)",
    {
        ["Select units.", {
            private _units = curatorSelected select 0;
            if (_units isEqualTo []) exitWith {
                ["No units selected.", "cancel"]
                    call a3aa_ares_extras_fnc_curatorMsg;
            };
            { deleteVehicle _x } forEach _units;
        }] call a3aa_ares_extras_fnc_confirm;
    }
] call zen_custom_modules_fnc_register;
