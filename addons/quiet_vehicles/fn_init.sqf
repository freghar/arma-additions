[
    "quiet_vehicles_enable",
    "CHECKBOX",
    ["Enable", "Enable player-configurable sound reduction in vehicles.\n\nAutomatically disabled when using ACEX Volume."],
    ["Arma Additions", "Quiet Vehicles"],
    true,  /* default */
    true,  /* isGlobal */
    nil,   /* script */
    true   /* needRestart */
] call CBA_settings_fnc_init;

[
    "quiet_vehicles_level",
    "SLIDER",
    ["Sound level", "Volume inside vehicles (0 = complete silence, 1 = normal volume)."],
    ["Arma Additions", "Quiet Vehicles"],
    [0, 1, 1, 1],  /* default; [min,max,default,trailing_decimal_digits] */
    nil,           /* isGlobal - let each client sets its own */
    {
        /* changed mid-mission; after CBA settings initialized */
        if (time > 0 && !isNil "Quiet_Vehicles_settings_initialized") then {
            [] call Quiet_Vehicles_fnc_adjustSoundVolume;
        };
    }
] call CBA_settings_fnc_init;

["CBA_settingsInitialized", {
    [] call Quiet_Vehicles_fnc_registerEHs;
    /* this also runs on mission start, for a player in a vehicle */
    0 = [] spawn {
        waitUntil { time > 0 };
        [] call Quiet_Vehicles_fnc_adjustSoundVolume;
    };
    Quiet_Vehicles_settings_initialized = true;
}] call CBA_fnc_addEventHandler;
