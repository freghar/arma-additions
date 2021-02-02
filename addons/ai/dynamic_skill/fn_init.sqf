[
    "a3aa_ai_dynamic_skill_preset",
    "LIST",
    ["Dynamic skill preset", "A flavor to the dynamic skill updating, decides which skill values to set, on what dynamic\nsituations those values depend, etc.\n\nFairly hardcore = AI aim like noobish players, expected K:D for a skilled player is ~3.\nPretty pisseasy = AI are a set dressing, give players plenty of time to shoot, K:D at ~10\nStatic 0.5 = skills are set to values that emulate vanilla 0.5 skill (nullifying CfgAISkill changes)\nNo change = do nothing, don't start up dynamic skill logic (note: custom CfgAISkill is in effect!)"],
    ["Arma Additions", "AI"],
    [
        ["hard","easy","static_vanilla", "nochange"],
        ["Fairly hardcore","Pretty pisseasy","Static 0.5 everything","No change"],
        0
    ],     /* default */
    true   /* isGlobal */
] call CBA_settings_fnc_init;

/*
 * have a mostly-static array of all units we want to update skills for
 * (filled by fn_initUnit) and a secondary array which gets refilled
 * from the primary one and consumed as we iterate the units in it
 */
a3aa_ai_dynamic_skill_units = [];
a3aa_ai_dynamic_skill_units_consumable = [];

["CBA_settingsInitialized", {
    /* setting calcSkills to final CODE makes it also final/readonly */
    switch (a3aa_ai_dynamic_skill_preset) do {
        case "hard": {
            a3aa_ai_dynamic_skill_fnc_calcSkills =
                a3aa_ai_dynamic_skill_fnc_presetHard;
        };
        case "easy": {
            a3aa_ai_dynamic_skill_fnc_calcSkills =
                a3aa_ai_dynamic_skill_fnc_presetEasy;
        };
        case "static_vanilla": {
            a3aa_ai_dynamic_skill_fnc_calcSkills =
                a3aa_ai_dynamic_skill_fnc_presetStaticVanilla;
        };
        default {
            a3aa_ai_dynamic_skill_fnc_calcSkills = nil;
        };
    };
    if (isNil "a3aa_ai_dynamic_skill_fnc_calcSkills") exitWith {};

    [
        "CAManBase",
        "init",
        {
            (_this select 0) call a3aa_ai_dynamic_skill_fnc_initUnit;
        },
        true,
        [],
        true
    ] call CBA_fnc_addClassEventHandler;

    /*
     * in ideal world, we'd run this everywhere and let each client update their
     * own units, but locality transfers would be a nightmare with all the state
     * variables (or network spam if we were to always broadcast them), so just
     * keep this server-only
     */ 
    if (!isServer) exitWith {};

    addMissionEventHandler ["EachFrame", {
        if (a3aa_ai_dynamic_skill_units_consumable isEqualTo []) then {
            a3aa_ai_dynamic_skill_units = a3aa_ai_dynamic_skill_units - [objNull];
            a3aa_ai_dynamic_skill_units_consumable = +a3aa_ai_dynamic_skill_units;
        } else {
            /* pop last unit in the array, process it */
            private _units = a3aa_ai_dynamic_skill_units_consumable;
            (_units deleteAt (count _units - 1))
                call a3aa_ai_dynamic_skill_fnc_updateUnit;
        };
    }];
}] call CBA_fnc_addEventHandler;
