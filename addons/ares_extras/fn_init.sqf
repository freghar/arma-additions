/*
 * register custom modules/functions in Zeus Enhanced (ZEN)
 */

if (isNil "zen_custom_modules_fnc_register") exitWith {};

[
    "A3AA",
    "Forget enemies",
    {
        [_this select 1, "Select units.", {
            {
                [_x, {
                    { _this forgetTarget _x } forEach (_this targets [true]);
                }] remoteExec ["call", _x];
            } forEach _this;
        }] call a3aa_ares_extras_fnc_selectUnits;
    },
    "\a3\Modules_F_Curator\Data\portraitSmoke_ca.paa"
] call zen_custom_modules_fnc_register;

[
    "A3AA",
    "Reveal enemies",
    {
        [_this select 1, "Select to-be-revealed units.", {
            [objNull, "Select to-be-informed groups.", [_this, {
                [_this, {
                    params ["_informed", "_revealed"];
                    {
                        private _toinform = _x;
                        {
                            _toinform reveal _x;
                        } forEach _revealed;
                    } forEach _informed;
                }] remoteExec ["call"];  /* reveal is EL, see wiki */
            }], "groups"] call a3aa_ares_extras_fnc_selectUnits;
        }] call a3aa_ares_extras_fnc_selectUnits;
    },
    "\a3\3DEN\Data\CfgWaypoints\SeekAndDestroy_ca.paa"
] call zen_custom_modules_fnc_register;

[
    "A3AA",
    "Watch",
    {
        params ["_pos", "_unit"];
        private _dst = _unit;
        if (isNil "_unit" || isNull _unit) then {
            _dst = ASLtoATL _pos;  /* use pos as dst */
        };
        [objNull, "Select watcher units.", [_dst, {
            params ["_units", "_dst"];
            {
                [_x, _dst] remoteExec ["doWatch"];
            } forEach _units;
        }]] call a3aa_ares_extras_fnc_selectUnits;
    },
    "\a3\Ui_f\data\IGUI\Cfg\simpleTasks\types\scout_ca.paa"
] call zen_custom_modules_fnc_register;

[
    "A3AA",
    "No unload in combat",
    {
        [_this select 1, "Select vehicles.", {
            {
                [_x, false, false] remoteExec ["setUnloadInCombat", _x];
            } forEach _this;
        }, "vehicles"] call a3aa_ares_extras_fnc_selectUnits;
    },
    "\a3\Ui_f\data\IGUI\Cfg\simpleTasks\types\car_ca.paa"
] call zen_custom_modules_fnc_register;

[
    "A3AA",
    "Flee",
    {
        [_this select 1, "Select groups.", {
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
            } forEach _this;
        }, "groups"] call a3aa_ares_extras_fnc_selectUnits;
    },
    "\a3\Modules_F_Tacops\Data\CivilianPresenceUnit\icon32_ca.paa"
] call zen_custom_modules_fnc_register;

[
    "A3AA",
    "Suppress (bis)",
    {
        params ["_pos", "_unit"];
        private _dst = _unit;
        if (isNil "_unit" || isNull _unit) then {
            _dst = ASLtoATL _pos;  /* use pos as dst */
        };
        [objNull, "Select sources (soldiers/vehicles).", [_dst, {
            params ["_units", "_dst"];
            /* doSuppressiveFire doesn't work well on position */
            if (!(_dst isEqualType objNull)) then {
                _dst = createVehicle ["Land_HelipadEmpty_F", _dst,
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
        }]] call a3aa_ares_extras_fnc_selectUnits;
    },
    "\a3\Ui_f\data\IGUI\Cfg\simpleTasks\types\kill_ca.paa"
] call zen_custom_modules_fnc_register;

[
    "A3AA",
    "Assign Task Force",
    {
        [objNull, "Select TF member groups.", {
            _this call a3aa_ares_extras_fnc_assignTaskForce;
        }, "groups"] call a3aa_ares_extras_fnc_selectUnits;
    },
    "\a3\Ui_f\data\IGUI\Cfg\simpleTasks\types\meet_ca.paa"
] call zen_custom_modules_fnc_register;

[
    "A3AA",
    "Force WP Setting",
    {
        [_this select 1, "Select groups.", {
            [_this, {
                {
                    {
                        _x setWaypointForceBehaviour true;
                        _x setWaypointBehaviour "AWARE";
                    } forEach waypoints _x;
                } forEach _this;
            }] remoteExec ["call", 2];
        }] call a3aa_ares_extras_fnc_selectUnits;
    },
    "\a3\3DEN\Data\CfgWaypoints\Move_ca.paa"
] call zen_custom_modules_fnc_register;

[
    "A3AA",
    "No Talking",
    {
        [_this select 1, "Select units.", {
            {
                [[_x, { _this setSpeaker "NoVoice" }], 0, _x, { !alive _this }]
                    call a3aa_fnc_remoteCallObj;
            } forEach _this;
        }] call a3aa_ares_extras_fnc_selectUnits;
    },
    "\a3\Ui_f\data\IGUI\Cfg\simpleTasks\types\talk_ca.paa"
] call zen_custom_modules_fnc_register;

[
    "A3AA",
    "Locality - Get",
    {
        [_this select 1, "Select units.", {
            [_this, {
                private _owners = _this apply { owner _x };
                (str _owners) remoteExec ["systemChat", remoteExecutedOwner];
            }] remoteExec ["call", 2];
        }] call a3aa_ares_extras_fnc_selectUnits;
    },
    "\a3\ui_f\data\map\vehicleicons\iconVirtual_ca.paa"
] call zen_custom_modules_fnc_register;

[
    "A3AA",
    "Locality - Set",
    {
        private _hcs = (entities "HeadlessClient_F") select { _x in allPlayers };
        private _targets =
            _hcs +
            [-1] +
            (allPlayers - _hcs);
        private _target_names =
            (_hcs apply { name _x }) +
            ["Server"] +
            ((allPlayers - _hcs) apply { name _x });
        [_this select 1, "Select groups to transfer.", [
            [_targets, _target_names],
            {
                params ["_groups", "_args"];
                _args params ["_targets", "_target_names"];
                [
                    "Locality - Set",
                    [
                        ["LIST", "Transfer to", [
                            _targets,
                            _target_names
                        ]]
                    ],
                    {
                        params ["_dialog_data", "_groups"];
                        _dialog_data params ["_target"];
                        [_target, _groups]
                            remoteExec ["a3aa_ares_extras_fnc_localitySet", 2];
                    },
                    nil,
                    _groups
                ] call zen_dialog_fnc_create;
            }
        ], "groups"] call a3aa_ares_extras_fnc_selectUnits;
    },
    "\a3\ui_f\data\map\vehicleicons\iconVirtual_ca.paa"
] call zen_custom_modules_fnc_register;

[
    "A3AA",
    "Promote to Zeus (lightweight)",
    {
        params ["_pos", "_unit"];
        if (isNull _unit) exitWith {
            ["No unit selected.", "cancel"]
                call a3aa_ares_extras_fnc_curatorMsg;
        };
        if (!(_unit in allPlayers)) exitWith {
            ["Unit is not a player soldier.", "cancel"]
                call a3aa_ares_extras_fnc_curatorMsg;
        };
        if (!isNull getAssignedCuratorLogic _unit) exitWith {
            ["Player already has Zeus.", "cancel"]
                call a3aa_ares_extras_fnc_curatorMsg;
        };
        [_unit, {
            /* race condition double check */
            if (!isNull getAssignedCuratorLogic _this) exitWith {};
            /* TODO: when adding curator recycling logic, pass no arg */
            private _curator = _this call a3aa_insta_zeus_fnc_mkCurator;
            [_this, _curator] spawn a3aa_insta_zeus_fnc_assignCurator;
        }] remoteExec ["call", 2];
    },
    "\a3\Modules_F_Curator\Data\portraitCurator_ca.paa"
] call zen_custom_modules_fnc_register;

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
    },
    "\a3\Modules_F\Data\HideTerrainObjects\icon32_ca.paa"
] call zen_custom_modules_fnc_register;

[
    "A3AA",
    "Set new player unit",
    {
        params ["_pos", "_unit"];
        if (isNull _unit) exitWith {
            ["No unit selected.", "cancel"]
                call a3aa_ares_extras_fnc_curatorMsg;
        };
        if (!(_unit isKindOf "CAManBase")) exitWith {
            ["Unit is not a soldier.", "cancel"]
                call a3aa_ares_extras_fnc_curatorMsg;
        };

        /* because we need to wait for all clients to report in */
        0 = _unit spawn {
            params ["_unit"];

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
            disableSerialization;
            [
                "Set new player unit",
                [
                    ["LIST", "For client", [_clients, _names, 0]]
                ],
                {
                    params ["_dialog_data", "_unit"];
                    _dialog_data params ["_client"];
                    _unit remoteExec ["selectPlayer", _client];
                },
                nil,
                _unit
            ] call zen_dialog_fnc_create;
        };
    },
    "\a3\Ui_f\data\Map\VehicleIcons\iconMan_ca.paa"
] call zen_custom_modules_fnc_register;

[
    "A3AA",
    "End Mission - Won",
    {
        { ["stop", cntr_exportPath] call cntr_fnc_export } remoteExecCall ["call", 2];
        ["end1", true] remoteExec ["BIS_fnc_endMission"];
    },
    "\a3\Modules_F_Curator\Data\portraitEndMission_ca.paa"
] call zen_custom_modules_fnc_register;
[
    "A3AA",
    "End Mission - Lost",
    {
        { ["stop", cntr_exportPath] call cntr_fnc_export } remoteExecCall ["call", 2];
        ["end1", false] remoteExec ["BIS_fnc_endMission"];
    },
    "\a3\Modules_F_Curator\Data\portraitEndMission_ca.paa"
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
    },
    "\a3\Missions_F_Curator\data\img\portraitMPTypeSectorControl_ca.paa"
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
    },
    "\a3\Missions_F_Curator\data\img\portraitMPTypeSectorControl_ca.paa"
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
    },
    "\a3\Missions_F_Curator\data\img\portraitMPTypeSectorControl_ca.paa"
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
    },
    "\a3\Missions_F_Curator\data\img\portraitMPTypeSectorControl_ca.paa"
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
    },
    "\a3\Missions_F_Curator\data\img\portraitMPTypeSectorControl_ca.paa"
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
    },
    "\a3\Missions_F_Curator\data\img\portraitMPTypeSectorControl_ca.paa"
] call zen_custom_modules_fnc_register;

[
    "A3AA",
    "Delete units (really)",
    {
        [_this select 1, "Select units to delete.", {
            { deleteVehicle _x } forEach _this;
        }] call a3aa_ares_extras_fnc_selectUnits;
    },
    "\a3\Ui_f\data\IGUI\Cfg\simpleTasks\types\danger_ca.paa"
] call zen_custom_modules_fnc_register;
