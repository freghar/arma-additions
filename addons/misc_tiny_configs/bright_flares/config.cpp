/*
 * bright flares - increase brightness/intensity of flares, so they
 * actually can illuminate something (even without NVGs!)
 * - taken from https://feedback.bistudio.com/T76756
 */

class CfgPatches {
    class a3aa_mtc_bright_flares {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {
            "A3_Weapons_F",
            "ace_grenades"     // overwrites flare intensity
        };
        addonRootClass = "A3_Weapons_F";
    };
};

#define FLARECFG \
    intensity = 500000; \
    size = 0.1; \
    timeToLive = 50; \
    coefGravity = 0.4;

class CfgAmmo {
    class FlareCore;
    class FlareBase;
    class Flare_82mm_AMOS_White : FlareCore {
        FLARECFG
    };
    class F_40mm_White : FlareBase {
        FLARECFG
    };
    class F_20mm_White : FlareBase {
        FLARECFG
    };
    class F_Signal_Green : FlareBase {
        FLARECFG
    };
    class F_40mm_Cir : F_40mm_White {
        nvgOnly = 1;
        useFlare = 0;
        irLock = 1;
    };
};
