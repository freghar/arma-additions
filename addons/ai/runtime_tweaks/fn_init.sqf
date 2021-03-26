[
    "a3aa_ai_crew_in_immobile_enabled",
    "CHECKBOX",
    ["Crew stays in immobile", "Let AI vehicle crew stay inside an otherwise immobile vehicle (wheels destroyed).\nIf the vehicle takes critical damage, the crew still dismounts."],
    ["Arma Additions", "AI"],
    true,  /* default */
    true   /* isGlobal */
] call CBA_settings_fnc_init;

[
    "a3aa_ai_disable_remote_raycasts",
    "CHECKBOX",
    ["Disable remote raycasts", "Save some CPU time by not calculating visibility raycasts (knowsAbout, etc.) for purely REMOTE groups.\nUnless you need to query AI targets of remote AI units from script, this should be safe.\n\nSee the disableRemoteSensors command on BI wiki."],
    ["Arma Additions", "AI"],
    true,  /* default */
    true,  /* isGlobal */
    {
        disableRemoteSensors _this;
    }
] call CBA_settings_fnc_init;

["CBA_settingsInitialized", {
    if (!a3aa_ai_crew_in_immobile_enabled) exitWith {};
    {
        [
            _x,
            "init",
            {
                (_this select 0) allowCrewInImmobile true;
            },
            true,
            [],
            true
        ] call CBA_fnc_addClassEventHandler;
    } forEach ["Car", "Air", "Tank", "Ship"];
}] call CBA_fnc_addEventHandler;
