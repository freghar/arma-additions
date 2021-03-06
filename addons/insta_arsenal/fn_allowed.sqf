/* allow for singleplayer */
if (!isMultiplayer) exitWith { true };

/* allow if logged or voted in, see fn_maintainCurator */
if (serverCommandAvailable "#kick") exitWith { true };

/* allow for any Zeus/Curator if allowed by settings */
if (!isNil "a3aa_settings_initialized" &&
    {a3aa_insta_arsenal_allow_for_curator} &&
    {!isNull getAssignedCuratorLogic player}) exitWith {
    true;
};

false;
