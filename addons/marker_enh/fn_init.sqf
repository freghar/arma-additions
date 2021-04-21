[
    "a3aa_marker_enh_enable",
    "CHECKBOX",
    ["Enable", "Allow rotating map markers via shift + mouse drag.\nAllow moving map markers via alt + mouse drag.\n\nAutomatically disabled when using ACE, use ACE Markers."],
    ["Arma Additions", "Marker Enhancer"],
    true,  /* default */
    true,  /* isGlobal */
    nil,   /* script */
    true   /* needRestart */
] call CBA_settings_fnc_init;

["CBA_settingsInitialized", {
    if (!hasInterface) exitWith {};
    if (isClass (configFile >> "CfgPatches" >> "ace_markers")) exitWith {};
    if (a3aa_marker_enh_enable) then {
        [] spawn a3aa_marker_enh_fnc_hookAnyMapDisplay;
    };
    nil;
}] call CBA_fnc_addEventHandler;
