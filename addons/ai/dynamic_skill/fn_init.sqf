[
    "a3aa_ai_dynamic_skill_preset",
    "LIST",
    ["Dynamic skill preset", "A flavor to the dynamic skill updating, decides which skill values to set, on what dynamic\nsituations those values depend, etc.\n\nFairly hardcore = AI aim like noobish players, expected K:D for a skilled player is ~3.\nFun easy = AI are a set dressing, give players plenty of time to shoot, K:D at ~15\nCustom function = define your own a3aa_ai_dynamic_skill_custom function\nNo change = do nothing, don't start up dynamic skill logic (note: custom CfgAISkill is in effect!)"],
    ["Arma Additions", "AI"],
    [
        ["hard","easy","custom","nochange"],
        ["Fairly hardcore","Fun easy","Custom function","No change"],
        1
    ],     /* default */
    true,  /* isGlobal */
    nil,   /* script */
    true   /* needRestart */
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
        case "custom": {
            if (isNil "a3aa_ai_dynamic_skill_custom") then {
                a3aa_ai_dynamic_skill_custom =
                    { [0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5] };
            };
            a3aa_ai_dynamic_skill_fnc_calcSkills =
                compileFinal "call a3aa_ai_dynamic_skill_custom";
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

    [
        {
            a3aa_ai_dynamic_skill_units = a3aa_ai_dynamic_skill_units - [objNull];
            a3aa_ai_dynamic_skill_units;
        },
        {
            _this call a3aa_ai_dynamic_skill_fnc_updateUnit;
        },
        10
    ] call a3aa_fnc_balancePerFrame;
}] call CBA_fnc_addEventHandler;
