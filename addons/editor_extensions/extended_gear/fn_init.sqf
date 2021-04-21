[
    "a3aa_ee_extended_gear_useprofile",
    "CHECKBOX",
    ["Default to per-player insignia", "When mission does not define any Extended Gear insignia,\nuse a player-defined one from profileNamespace."],
    ["Arma Additions", "Editor Extensions - Extended Gear"],
    true,  /* default */
    true,  /* isGlobal */
    nil,   /* script */
    true   /* needRestart */
] call CBA_settings_fnc_init;

([] call a3aa_ee_extended_gear_fnc_collectCfgInsigniaAsSettings) params ["_insignia_classes", "_insignia_names"];
[
    "a3aa_ee_extended_gear_player_insignia",
    "LIST",
    ["Player insignia", "This is a per-client specific insignia, set it per your preference.\nUsed only when the above option is enabled and when not\novewritten by the mission otherwise."],
    ["Arma Additions", "Editor Extensions - Extended Gear"],
    [
        _insignia_classes,
        _insignia_names,
        0
    ],     /* default */
    nil,   /* isGlobal */
    {
        /* re-draw new insignia mid-game */
        private _saved = missionNamespace getVariable "a3aa_ee_extended_gear_saved";
        if (isNil "_saved") exitWith {};  /* too early / not during runtime */
        if (isNil "a3aa_ee_extended_gear_player_insignia_used") exitWith {};
        [player, _this] call a3aa_ee_extended_gear_fnc_setUnitInsignia;
        _saved set [1, _this];
    }
] call CBA_settings_fnc_init;

["CBA_settingsInitialized", {
    0 = [] spawn a3aa_ee_extended_gear_fnc_setupExtendedGear;
}] call CBA_fnc_addEventHandler;
