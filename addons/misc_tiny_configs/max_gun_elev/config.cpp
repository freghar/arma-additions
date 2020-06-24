/*
 * max gun elev - no angle limitation on soldier aiming upwards/downwards
 */

class CfgPatches {
    class a3aa_mtc_max_gun_elev {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {
            "A3_Characters_F"
        };
    };
};

class CfgVehicles {
    class Man;
    class CAManBase : Man {
        /*
         * 90 causes weird glitches;
         * default vanilla: -80 down, 60 up
         * default ACE: -80 down, 80 up
         */
        minGunElev = -89;
        maxGunElev = 89;
    };
};
