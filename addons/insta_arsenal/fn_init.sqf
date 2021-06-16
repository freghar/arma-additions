[
    ["Arma Additions", "Insta Arsenal"],
    "a3aa_insta_arsenal_open",
    "Open Arsenal",
    { "open" call a3aa_insta_arsenal_fnc_arsenal }
] call CBA_fnc_addKeybind;
[
    ["Arma Additions", "Insta Arsenal"],
    "a3aa_insta_arsenal_open_ace",
    "Open ACE Arsenal",
    { "ace_open" call a3aa_insta_arsenal_fnc_arsenal }
] call CBA_fnc_addKeybind;
[
    ["Arma Additions", "Insta Arsenal"],
    "a3aa_insta_arsenal_spawn_bag",
    "Spawn Arsenal bag on mouse",
    { "spawn" call a3aa_insta_arsenal_fnc_arsenal }
] call CBA_fnc_addKeybind;

[
    "a3aa_insta_arsenal_allow_for_curator",
    "CHECKBOX",
    ["Allow for any Zeus", "Allow access to arsenal for any (non-admin) player with assigned Zeus/Curator.\n\nDisable this if you're running ie. ZvZ or ZvP scenarios with limited Zeus powers."],
    ["Arma Additions", "Insta Arsenal"],
    true,  /* default */
    true   /* isGlobal */
] call CBA_settings_fnc_init;
