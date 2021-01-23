class CfgPatches {
    class a3aa_ai_cfg_ai_skill {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {};
    };
};

/*
 * linear X=Y from 0.2 up, don't ask how, took 3 days of research
 * https://drive.google.com/open?id=1GDzxZpVa1IDFP9GAeHUVrKIiGqKR5jv68qvE-0JhMQ0
 *
 * default UI slider ranges in Eden / Zeus are 0.2 to 1.0, so the user won't set
 * values below 0.2 via UI
 */
class CfgAISkill {
    aimingAccuracy[] = {0,0, 0.5,0, 1,1};
    aimingShake[]    = {0,0, 0.5,0, 1,1};
    aimingSpeed[]    = {0,0, 0.5,0, 1,1};
    endurance[]      = {0,0, 0.5,0, 1,1};
    spotDistance[]   = {0,0, 0.5,0, 1,1};
    spotTime[]       = {0,0, 0.5,0, 1,1};
    courage[]        = {0,0, 0.5,0, 1,1};
    reloadSpeed[]    = {0,0, 0.5,0, 1,1};
    commanding[]     = {0,0, 0.5,0, 1,1};
    general[]        = {0,0, 0.5,0, 1,1};
};
