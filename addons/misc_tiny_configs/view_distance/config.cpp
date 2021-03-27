/*
 * allow a greater view distance in vanilla Arma by default
 */

class CfgPatches {
    class a3aa_mtc_view_distance {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {
            "A3_Ui_F"
        };
    };
};

class CfgDefaultSettings {
    /* default 1600 */
    defaultVisibility = 4000;
    defaultObjectViewDistance = 4000;
    defaultTerrainGrid = 25;
};
