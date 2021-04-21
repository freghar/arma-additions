/*
 * silent op - a super quiet soldier for special silent operations
 */

class CfgPatches {
    class a3aa_mtc_silent_op {
        units[] = {
            "a3aa_silent_ops_silent_operative",
            "a3aa_silent_ops_silent_expert"
        };
        weapons[] = {};
        requiredAddons[] = {
            "A3_Characters_F"
        };
    };
};

class CfgVehicles {
    class B_Soldier_recon_base;
    class a3aa_silent_ops_silent_operative : B_Soldier_recon_base {
        scope = 2;
        side = 3;  /* allows using any uniforms */
        faction = "CIV_F";
        displayName = "Silent Operative";
        camouflage = 0.3;
        audible = 0.002;
        /*
         * I should actually just re-define all of the 9000 sounds, but with lower
         * volume .. though it would be a lot of variables to break on Arma update.
         * The class Sound* thing is really lazy, but as there are still *some*
         * quiet footstep sounds, it works reasonably well in practice.
         */
        class SoundEnvironExt {};
        class SoundGear {};
    };
    class a3aa_silent_ops_silent_expert : a3aa_silent_ops_silent_operative {
        displayName = "Silent Operative (Expert)";
        attendant = 1;
        engineer = 1;
        uavHacker = 1;
        canDeactivateMines = 1;
        canHideBodies = 1;
    };
};

class CfgAddons {
    class PreloadAddons {
        class a3aa_mtc_silent_op {
            list[] = { "a3aa_mtc_silent_op" };
        };
    };
};
