/*
 * RHS vanilla ammo - make various RHS weapons (mostly AFRF) use vanilla
 * CfgAmmo, especially in cases where the AFRF version is buggy or the
 * vanilla version has been modified/fixed by another tweak
 *
 * This is generally needed because RHS AFRF (unlike RHS USAF) likes to
 * define everything from scratch, not inherit vanilla classes.
 *
 * - note that magazines stay the same, so this shouldn't have any notable
 *   negative gameplay effect
 */

class CfgPatches {
    class a3aa_mtc_rhs_vanilla_ammo {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {
            "rhsusf_c_weapons",
            "rhs_c_weapons"
        };
        addonRootClass = "rhsusf_c_weapons";
    };
};

class CfgMagazines {
    /* throwable and UGL smokes - reduced bounce (tweak), ACE Particles, etc. */
    /* rhs - usf */
    class rhs_mag_M441_HE;
    class rhs_mag_m713_Red : rhs_mag_M441_HE { ammo = "G_40mm_SmokeRed"; };
    class rhs_mag_m714_White : rhs_mag_m713_Red { ammo = "G_40mm_Smoke"; };
    class rhs_mag_m715_Green : rhs_mag_m713_Red { ammo = "G_40mm_SmokeGreen"; };
    class rhs_mag_m716_yellow : rhs_mag_m713_Red { ammo = "G_40mm_SmokeYellow"; };
    /* rhs - afrf */
    class rhs_VOG25;
    class rhs_GRD40_White : rhs_VOG25 { ammo = "G_40mm_Smoke"; };
    class rhs_GRD40_Green : rhs_GRD40_White { ammo = "G_40mm_SmokeGreen"; };
    class rhs_GRD40_Red : rhs_GRD40_White { ammo = "G_40mm_SmokeRed"; };
    /* UGL usaf flares */
    //class rhs_mag_M441_HE;
    class rhs_mag_M585_white : rhs_mag_M441_HE { ammo = "F_40mm_White"; };
    class rhs_mag_m661_green : rhs_mag_M585_white { ammo = "F_40mm_White"; };
    class rhs_mag_m662_red : rhs_mag_M585_white { ammo = "F_40mm_Red"; };
    /* UGL afrf flares */
    //class rhs_VOG25;
    class rhs_VG40OP_white : rhs_VOG25 { ammo = "F_40mm_White"; };
    class rhs_VG40OP_green : rhs_VG40OP_white { ammo = "F_40mm_Green"; };
    class rhs_VG40OP_red : rhs_VG40OP_white { ammo = "F_40mm_Red"; };
    /* pistol slot afrf hand-held flares */
    class UGL_FlareWhite_F;
    class rhs_mag_rsp30_white : UGL_FlareWhite_F { ammo = "F_40mm_White"; };
    class UGL_FlareGreen_F;
    class rhs_mag_rsp30_green : UGL_FlareGreen_F { ammo = "F_40mm_Green"; };
    class UGL_FlareRed_F;
    class rhs_mag_rsp30_red : UGL_FlareRed_F { ammo = "F_40mm_Red"; };
};
