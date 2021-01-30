/* allow for singleplayer or "fake" multiplayer (Apex campaign) */
if (!isMultiplayer || isMultiplayerSolo) exitWith { true };

/* allow if logged or voted in, see fn_maintainCurator */
if (serverCommandAvailable "#kick") exitWith { true };

/* allow for any Zeus/Curator if allowed by settings */
if (!isNil "a3aa_insta_arsenal_settings_initialized" &&
    {a3aa_insta_arsenal_allow_for_curator} &&
    {!isNull getAssignedCuratorLogic player}) exitWith {
    true;
};

false;
