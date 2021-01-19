/*
 * better video settings - allow higher quality values in Video Settings
 *
 * BE AWARE that many of these can have SEVERE performance impact!
 * - use mostly for screenshots and/or test changes first
 */

class CfgPatches {
    class a3aa_mtc_better_video_settings {
        units[] = {};
        weapons[] = {};
        magazines[] = {};
        requiredAddons[] = {};
    };
};

#define PREFIX(cls) a3aa_mtc_better_video_settings_##cls
#define NAME_VAL(name, txt, arg) \
    class PREFIX(name) { \
        text = txt; \
        value = arg; \
    }

class CfgVideoOptions {
    class DynamicLights {
        /* more seems to be ignored by the engine */
        NAME_VAL(extra_ultra,"Extra Ultra",32);
    };
    class Visibility {
        maxValue = 50000;
    };
    class ObjectsVisibility {
        maxValue = 50000;
    };
#ifdef did_not_have_significant_effect
    class Particles {
        /* https://community.bistudio.com/wiki/Arma_3:_Particle_Effects */
        class High;
        class PREFIX(extra_high) : High {
            text = "Extra High";
            particlesSoftLimit = 100000;
            particlesHardLimit = 120000;
            smokeGenMinDist = 500;
            smokeGenMaxDist = 3000;
            numFullSizeParticles = 1000;
        };
    };
#endif
    class PiP {
        NAME_VAL(3000,"Extra Ultra (3000m)",3000);
        NAME_VAL(4000,"Extra Ultra (4000m)",4000);
        NAME_VAL(5000,"Extra Ultra (5000m)",5000);
        NAME_VAL(8000,"Extra Ultra (8000m)",8000);
        NAME_VAL(10000,"Extra Ultra (10000m)",10000);
        NAME_VAL(15000,"Extra Ultra (15000m)",15000);
        NAME_VAL(20000,"Extra Ultra (20000m)",20000);
        NAME_VAL(50000,"Extra Ultra (50000m)",50000);
    };
    class ShadowQuality {
        class VeryHigh;
        class PREFIX(extra_ultra) : VeryHigh {
            text = "Extra Ultra";
            textureSize = 4096;  /* max allowed */
        };
    };
    class ShadowsVisibility {
        /* watch out! larger distance = worse shadow quality */
        maxValue = 2500;  /* no effect beyond this */
    };
};
