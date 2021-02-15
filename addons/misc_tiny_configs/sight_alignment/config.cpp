/*
 * sight alignment - make iron sight (and red dot, etc.) alignment slower
 *
 * since Arma 3 simulates sight alignment, these imperfections manifest as
 * inaccuracy on 300+ meters, helping fix the iron sight sniper problem
 */

class CfgPatches {
    class a3aa_mtc_sight_alignment {
        units[] = {};
        weapons[] = {};
        magazines[] = {};
        requiredAddons[] = {
            "A3_Data_F"
        };
    };
};

class CfgWeaponHandling {
    class SightAlignment {
        /*
         * maximum misalignment from a perfect axis between eye and target
         * (higher = larger misalignment)
         */
        maximum = 0.8;  // default: 0.7
        /*
         * how quickly is the misalignment corrected when not moving mouse
         * (higher = faster recovery)
         */
        decay = 1;  // default: 1.8
        /*
         * how quickly is the alignment thrown off (ie. by small mouse moves),
         * eg. how resistant the alignment is to motion
         * (higher = faster misalignment)
         */
        rate = 0.4;  // default: 0.1
        /*
         * how much worse the effect is when looking down sights vs hip-aiming
         * (multiplier, higher = worse)
         */
        //gunnerCoef = 0.2;  // default: 0.2
    };
};
