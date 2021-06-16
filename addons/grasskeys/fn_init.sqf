[
    ["Arma Additions", "GrassKeys"],
    "a3aa_grasskeys_low",
    "Low (no grass)",
    { "low" call a3aa_grasskeys_fnc_setTerrain }
] call CBA_fnc_addKeybind;
[
    ["Arma Additions", "GrassKeys"],
    "a3aa_grasskeys_standard",
    "Standard",
    { "standard" call a3aa_grasskeys_fnc_setTerrain }
] call CBA_fnc_addKeybind;
[
    ["Arma Additions", "GrassKeys"],
    "a3aa_grasskeys_high",
    "High",
    { "high" call a3aa_grasskeys_fnc_setTerrain }
] call CBA_fnc_addKeybind;
[
    ["Arma Additions", "GrassKeys"],
    "a3aa_grasskeys_veryhigh",
    "Very High",
    { "veryhigh" call a3aa_grasskeys_fnc_setTerrain }
] call CBA_fnc_addKeybind;
[
    ["Arma Additions", "GrassKeys"],
    "a3aa_grasskeys_ultra",
    "Ultra",
    { "ultra" call a3aa_grasskeys_fnc_setTerrain }
] call CBA_fnc_addKeybind;

[
    "a3aa_grasskeys_enable",
    "CHECKBOX",
    ["Enable", "Allow using the keybinds, otherwise a default terrainGrid from server .Arma3Profile is used."],
    ["Arma Additions", "GrassKeys"],
    true,  /* default */
    true   /* isGlobal */
] call CBA_settings_fnc_init;
[
    "a3aa_grasskeys_hidegrass",
    "CHECKBOX",
    ["Hide grass on ""Low"" setting", "Hide grass on the lowest terrain grid setting."],
    ["Arma Additions", "GrassKeys"],
    true,  /* default */
    true   /* isGlobal */
] call CBA_settings_fnc_init;
