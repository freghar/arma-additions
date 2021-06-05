/*
 * set some reasonable values for a multiplayer respawn-enabled mission
 */

if (!is3DEN) exitWith {};

/*
 * see https://community.bistudio.com/wiki/Eden_Editor:_Setting_Attributes
 * and https://community.bistudio.com/wiki/get3DENMissionAttribute
 */
set3DENMissionAttributes [
    ["Scenario", "Saving", false],
    ["Scenario", "EnableDebugConsole", 1],
    ["Scenario", "SaveBinarized", false],

    ["Multiplayer", "DisabledAI", true],
    ["Multiplayer", "Respawn", 3],  // on custom location
    ["Multiplayer", "RespawnTemplates", []],
    ["Multiplayer", "RespawnDelay", 10],
    ["Multiplayer", "RespawnVehicleDelay", 10],
    ["Multiplayer", "RespawnDialog", false],
    ["Multiplayer", "AIKills", false],

    ["Multiplayer", "ReviveMode", 1],            // enabled
    ["Multiplayer", "ReviveRequiredTrait", 0],   // anyone
    ["Multiplayer", "ReviveRequiredItems", 2],   // big Medikit or FirstAid kit
    ["Multiplayer", "ReviveDelay", 40],          // how long to hold
    ["Multiplayer", "ReviveMedicSpeedMultiplier", 2],
    ["Multiplayer", "ReviveForceRespawnDelay", 3],
    ["Multiplayer", "ReviveUnconsciousStateMode", 0],  // basic
    ["Multiplayer", "ReviveBleedOutDelay", 300]  // how long before death
];
