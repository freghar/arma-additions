/*
 * Disable player contact reports, shouting when suppressed,
 * reporting injury, etc.
 */

class CfgPatches {
    class a3aa_player_novoice {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {};
    };
};

class CfgFunctions {
    class a3aa_player_novoice {
        class all {
            file = "\a3aa\player_novoice";
            class init { postInit = 1; };
        };
    };
};
