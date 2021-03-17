/*
 * CfgLights fixes - various light intensity/attenuation tweaks
 */

class CfgPatches {
    class a3aa_mtc_cfglights_fixes {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {
            "A3_Data_F_ParticleEffects"
        };
    };
};

/*
 * quadratic attenuation seems to be special:
 * - when set to 0, it seems to behave as if set to 1
 * - when set to 1 or above, it behaves as documented
 * - when set between 0 and 1, it multiplies intensity by (1/val)
 */

/*
 * do multiple kinds of tweaks:
 * - set all attenuation to zero to avoid observer-specific issues
 *   as seen with flashlights
 * - compensate for quadratic between 0 and 1 by multiplying intensity
 *   appropriately
 * - adjust min/max hard limits to some sane values to avoid broken
 *   wall-pass-trough dynamic lighting on large distances
 * - adjust intensity if obviously broken
 */

#define MINIMAL_ATTENUATION \
    start = 0; \
    constant = 0; \
    linear = 0; \
    quadratic = 1;

class CfgLights {
    /*
     * fireplaces are completely broken in vanilla, but removing
     * the attenuation seems to fix them like they were in pre-v1.60
     */
    class SmallFireLight {
        //intensity = "2500*(power interpolate[0.1, 1.0, 0.4, 1.0])";
        class Attenuation {
            //start = 0;
            //constant = 3;
            //linear = 0;
            //quadratic = 32;
            MINIMAL_ATTENUATION
        };
    };
    class SmallFirePlaceLight {
        //intensity = "1200*(power interpolate[0.1, 1.0, 0.4, 1.0])";
        class Attenuation {
            //start = 0;
            //constant = 3;
            //linear = 0;
            //quadratic = 22;
            MINIMAL_ATTENUATION
        };
    };

    /*
     * chemlights are alright, but pretty dim, reducing attenuation
     * seems to help somewhat
     */
    class Chemlight_Green {
        //intensity = 4000;
        class Attenuation {
            //start = 0;
            //constant = 1;
            //linear = 0;
            //quadratic = 5;
            MINIMAL_ATTENUATION
        };
    };

    /*
     * burning vehicle wrecks
     * - these are fine in vanilla, but use sub-1 quadratic and also
     *   illuminate objects way beyond the light visual range (hard limits)
     */
    class ObjectDestructionLight {
        intensity = 25000*(1/0.2);
        class Attenuation {
            //start = 0;
            //constant = 0;
            //linear = 0;
            //quadratic = 0.2;
            MINIMAL_ATTENUATION
            hardLimitStart = 150;  // 400
            hardLimitEnd = 200;    // 800
        };
    };
    /* no clue what this one is used for */
    /*class ObjectDestructionLightSmall {
        //intensity = 3500;
        class Attenuation {
            //start = 1;
            //constant = 3;
            //linear = 0;
            //quadratic = 22;
        };
    };*/

    /*
     * mines, AT/AA/etc. rockets, missiles, bombs, arty shells
     */
    class ExploLight {
        // default: 100000 ; with quad adj.: 100000*(1/0.2)
        intensity = 200000;
        class Attenuation {
            //start = 4;
            //constant = 0;
            //linear = 0;
            //quadratic = 0.2;
            MINIMAL_ATTENUATION
            hardLimitStart = 400;  // 1000
            hardLimitEnd = 600;    // 2000
        };
    };
    /*
     * IEDs, some rockets, completely broken in vanilla
     */
    class ExploLightMed {
        intensity = 80000;  // 1200
        class Attenuation {
            //start = 3;
            //constant = 0;
            //linear = 0;
            //quadratic = 5;
            MINIMAL_ATTENUATION
            hardLimitStart = 300;  // 800
            hardLimitEnd = 500;    // 1600
        };
    };
    /*
     * grenades, mortars, some secondary explosions
     */
    class GrenadeExploLight {
        intensity = 50000;  // 10000
        class Attenuation {
            //start = 0;
            //constant = 0;
            //linear = 0;
            //quadratic = 2.2;
            MINIMAL_ATTENUATION
            hardLimitStart = 300;  // 500
            hardLimitEnd = 500;    // 1000
        };
    };
    /*
     * just underwater mines
     */
    class MineExploLight {
        intensity = 45000*(1/0.3);
        class Attenuation {
            //start = 0.5;
            //constant = 0;
            //linear = 0;
            //quadratic = 0.3;
            MINIMAL_ATTENUATION
            hardLimitStart = 400;  // 1500
            hardLimitEnd = 600;    // 3000
        };
    };

    /*
     * some IED / explosion related fires?, seems kinda unused
     */
    class SmallFlameLight {
        //intensity = 3000;
        class Attenuation {
            //start = 0;
            //constant = 0;
            //linear = 0;
            //quadratic = 5;
            MINIMAL_ATTENUATION
        };
    };
    /*
     * 155mm AMOS "mortar", R_230mm_HE, ...
     */
    class FiredLightMed {
        //intensity = 80000;
        class Attenuation {
            //start = 0;
            //constant = 0;
            //linear = 0;
            //quadratic = 2;
            MINIMAL_ATTENUATION
            //hardLimitStart = 300;
            //hardLimitEnd = 600;
        };
    };
    /*
     * 105/120/125mm cannons (tanks?)
     */
    class FiredLightCannon : FiredLightMed {
        //intensity = 80000;
        class Attenuation {
            //start = 0;
            //constant = 0;
            //linear = 0;
            //quadratic = 2;
            MINIMAL_ATTENUATION
            //hardLimitStart = 300;
            //hardLimitEnd = 600;
        };
    };
    /*
     * just RPG32 backblast
     */
    class FiredLightLauncher {
        //intensity = 1500;
        class Attenuation {
            //start = 0;
            //constant = 0;
            //linear = 0;
            //quadratic = 2;
            MINIMAL_ATTENUATION
            //hardLimitStart = 300;
            //hardLimitEnd = 600;
        };
    };
    /*
     * just NLAW/Titan backblast
     */
    class FiredLightLauncherSmall {
        //intensity = 550;
        class Attenuation {
            //start = 0;
            //constant = 0;
            //linear = 0;
            //quadratic = 2;
            MINIMAL_ATTENUATION
            //hardLimitStart = 300;
            //hardLimitEnd = 600;
        };
    };

    /*
     * second light for mortars firing; maybe some unknown autocannons?
     */
    class FiredLightSmall {
        //intensity = 300;
        class Attenuation {
            //start = 0.1;
            //constant = 10;
            //linear = 0;
            //quadratic = 150;
            MINIMAL_ATTENUATION
            hardLimitStart = 200;  // 500
            hardLimitEnd = 400;    // 1000
        };
    };
    /*
     * some (?) missiles
     */
    class RocketLight {
        //intensity = 25000;
        class Attenuation {
            //start = 0;
            //constant = 0;
            //linear = 0;
            //quadratic = 1;
            MINIMAL_ATTENUATION
            hardLimitStart = 200;  // 100
            hardLimitEnd = 400;    // 200
        };
    };
    /*
     * just the ship-based cruise missile
     */
    class CruiseMissileLight {
        //intensity = 25000;
        flareMaxDistance = 800;  // 2600
        class Attenuation {
            //start = 0;
            //constant = 0;
            //linear = 0;
            //quadratic = 1;
            MINIMAL_ATTENUATION
            hardLimitStart = 200;  // 100
            hardLimitEnd = 400;    // 200
        };
    };

    /*
     * these two are probably the "sparks" from armor piercing
     * rounds hitting targets (buildings)
     */
    /*class SparksLight {
        intensity = 30;
        class Attenuation {
            start = 0.05;
            constant = 0;
            linear = 0;
            quadratic = 40;
            hardLimitStart = 2;
            hardLimitEnd = 4;
        };
    };
    class SparksLightSabot {
        intensity = 1000;
        class Attenuation {
            start = 0;
            constant = 0;
            linear = 0;
            quadratic = 1;
            hardLimitStart = 40;
            hardLimitEnd = 80;
        };
    };*/
};
