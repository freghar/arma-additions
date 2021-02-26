#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

/* in MP, allow only for admin */
if (isMultiplayer && !serverCommandAvailable "#kick") exitWith {};

params ["_variant", "_action"];

private _iscurator = { !isNull findDisplay IDD_RSCDISPLAYCURATOR };

if (_variant == "editor_curator" && (!is3DEN && !([] call _iscurator))) exitWith {};
if (_variant == "1st_3rd_person" && (is3DEN || ([] call _iscurator))) exitWith {};

if (is3DEN) then {
    _variant = "editor";
} else {
    if ([] call _iscurator) then {
        _variant = "curator";
    } else {
        _variant = "soldier";
    };
};

switch (_variant) do {
    case "editor": {
        private _units = (get3DENSelected "object") select { _x isKindOf "CAManBase" };
        switch (_action) do {
            case "copy": {
                if (count _units != 1) exitWith {
                    ["Need exactly one soldier unit selected.", 1]
                        call BIS_fnc_3DENNotification;
                };
                private _loadout = getUnitLoadout (_units select 0);
                _loadout call a3aa_ee_arsenal_respawn_fnc_acreFixRadios;
                copyToClipboard str _loadout;
            };
            case "paste": {
                if (_units isEqualTo []) exitWith {
                    ["Need one or more soldier units selected.", 1]
                        call BIS_fnc_3DENNotification;
                };
                private _loadout = parseSimpleArray copyFromClipboard;
                if (!isNil "_loadout") then {
                    _loadout call a3aa_ee_arsenal_respawn_fnc_acreFixRadios;
                    collect3DENHistory {
                        { _x setUnitLoadout [_loadout, false] } forEach _units;
                        save3DENInventory _units;
                    };
                };
            };
        };
    };
    case "curator": {
        private _units = (curatorSelected select 0) select { _x isKindOf "CAManBase" };
        switch (_action) do {
            case "copy": {
                if (count _units != 1) exitWith {
                    ["Loadout Copy Error",
                     "Need exactly one soldier unit selected.", 2]
                        call BIS_fnc_curatorHint;
                };
                private _loadout = getUnitLoadout (_units select 0);
                _loadout call a3aa_ee_arsenal_respawn_fnc_acreFixRadios;
                a3aa_loadout_copier_transient_loadout = _loadout;
                if (isServer) then { copyToClipboard str _loadout };
            };
            case "paste": {
                if (_units isEqualTo []) exitWith {
                    ["Loadout Paste Error",
                     "Need one or more soldier units selected.", 2]
                        call BIS_fnc_curatorHint;
                };
                if (isMultiplayer) then {
                    if (isNil "a3aa_loadout_copier_transient_loadout") exitWith {
                        ["Loadout Paste Error",
                        "No loadout copied (and cannot paste clipboard in MP).", 3]
                            call BIS_fnc_curatorHint;
                    };
                    private _loadout = a3aa_loadout_copier_transient_loadout;
                    { _x setUnitLoadout [_loadout, false] } forEach _units;
                } else {
                    private _loadout = parseSimpleArray copyFromClipboard;
                    if (!isNil "_loadout") then {
                        _loadout call a3aa_ee_arsenal_respawn_fnc_acreFixRadios;
                        { _x setUnitLoadout [_loadout, false] } forEach _units;
                    };
                };
            };
        };
    };
    case "soldier": {
        private _target = [] call CBA_fnc_currentUnit;
        if (isNull _target) exitWith {};
        private _cursor = cursorTarget;
        if (_cursor isKindOf "CAManBase" && {_target distance _cursor < 50}) then {
            _target = _cursor;
        };
        switch (_action) do {
            case "copy": {
                systemChat format ["Copying loadout of %1", name _target];
                private _loadout = getUnitLoadout _target;
                _loadout call a3aa_ee_arsenal_respawn_fnc_acreFixRadios;
                a3aa_loadout_copier_transient_loadout = _loadout;
                if (isServer) then { copyToClipboard str _loadout };
            };
            case "paste": {
                systemChat format ["Pasting loadout to %1", name _target];
                if (isMultiplayer) then {
                    if (isNil "a3aa_loadout_copier_transient_loadout") exitWith {
                        systemChat "No loadout copied (and cannot paste clipboard in MP).";
                    };
                    private _loadout = a3aa_loadout_copier_transient_loadout;
                    _target setUnitLoadout [_loadout, false];
                } else {
                    private _loadout = parseSimpleArray copyFromClipboard;
                    if (!isNil "_loadout") then {
                        _loadout call a3aa_ee_arsenal_respawn_fnc_acreFixRadios;
                        _target setUnitLoadout [_loadout, false];
                    };
                };
            };
        };
    };
};
