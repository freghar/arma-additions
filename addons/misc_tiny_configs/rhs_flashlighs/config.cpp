/*
 * rhs flashlights - make some RHS flashlights similar to vanilla
 */

class CfgPatches {
    //TODO: rename to a3aa_mtc_rhs_flashlights after some time
    //      (after missions drop requiredaddon dep)
    class a3aa_mtc_rhs_map_flashlights {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {
            "rhs_c_weapons",    // rhs_acc_2dpZenit
            "rhsusf_c_weapons"  // rhsusf_acc_M952V
        };
        addonRootClass = "rhsusf_c_weapons";
    };
};

class CfgWeapons {
    class InventoryFlashLightItem_Base_F;
    class acc_flashlight;
    class rhs_acc_2dpZenit : acc_flashlight {
        class ItemInfo : InventoryFlashlightItem_Base_F {
            mass = 1;
            class FlashLight {
                ACE_Flashlight_Colour = "white";
                ACE_Flashlight_Beam = "\z\ace\addons\map\UI\Flashlight_beam_white_ca.paa";
                ACE_Flashlight_Size = 2.5;
                ACE_Flashlight_Sound = 1;

                color[] = {180, 160, 130};
                ambient[] = {0.9, 0.81, 0.7};

                #include "..\bright_flashlight\flashlight_params.h"
            };
        };
    };
    class acc_pointer_IR;
    class rhsusf_acc_anpeq15 : acc_pointer_IR {
        class ItemInfo;
    };
    class rhsusf_acc_anpeq15_light : rhsusf_acc_anpeq15 {
        class ItemInfo : ItemInfo {
            class Flashlight {
                ACE_Flashlight_Colour = "white";
                ACE_Flashlight_Beam = "\z\ace\addons\map\UI\Flashlight_beam_white_ca.paa";
                ACE_Flashlight_Size = 2.5;
                ACE_Flashlight_Sound = 1;

                color[] = {180, 160, 130};
                ambient[] = {0.9, 0.81, 0.7};

                #include "..\bright_flashlight\flashlight_params.h"
            };
        };
    };
    class rhsusf_acc_M952V : rhsusf_acc_anpeq15_light {
        /* "flashlight" inventory image, instead of laser package */
        picture = "\A3\weapons_F\Data\UI\gear_accv_flashlight_CA.paa";
        class ItemInfo : ItemInfo {
            mass = 1;
        };
    };
};
