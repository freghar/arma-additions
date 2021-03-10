/*
 * rhs flashlights - make some RHS flashlights similar to vanilla
 */

class CfgPatches {
    class a3aa_mtc_rhs_flashlights {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {
            "rhs_c_weapons",    // rhs_acc_2dpZenit
            "rhsusf_c_weapons"  // rhsusf_acc_anpeq15_light
        };
    };
};

#include "..\bright_flashlight\flashlight_params.h"

/* same as FLASHLIGHT_VANILLA_DEFAULTS except "flashdir" vs "flash dir" */
#define FLASHLIGHT_VANILLA_AFRF_DEFAULTS \
    color[] = {180,160,130}; \
    ambient[] = {0.9,0.81,0.7}; \
    size = 1; \
    position = "flashdir"; \
    direction = "flash"; \
    useFlare = 1; \
    scale[] = {0};

#define ACE_FLASHLIGHT_PARAMS \
    ACE_Flashlight_Colour = "white"; \
    ACE_Flashlight_Beam = "\z\ace\addons\map\UI\Flashlight_beam_white_ca.paa"; \
    ACE_Flashlight_Size = 2.5; \
    ACE_Flashlight_Sound = 1;

class CfgWeapons {
    /*
     * RHS AFRF - 2DP flashlight
     */
    class InventoryFlashLightItem_Base_F;
    class acc_flashlight;
    class rhs_acc_2dpZenit : acc_flashlight {
        class ItemInfo : InventoryFlashlightItem_Base_F {
            mass = 1;
            class FlashLight {
                FLASHLIGHT_VANILLA_AFRF_DEFAULTS
                ACE_FLASHLIGHT_PARAMS
                FLASHLIGHT_MIDRANGE
            };
        };
        MRT_SwitchItemNextClass = "a3aa_rhs_acc_2dpZenit_far";
        MRT_SwitchItemPrevClass = "a3aa_rhs_acc_2dpZenit_near";
        MRT_switchItemHintText = "Mode: Standard";
    };
    class a3aa_rhs_acc_2dpZenit_near : rhs_acc_2dpZenit {
        scope = 1;
        class ItemInfo : ItemInfo {
            class FlashLight {
                FLASHLIGHT_VANILLA_AFRF_DEFAULTS
                ACE_FLASHLIGHT_PARAMS
                FLASHLIGHT_NEAR
            };
        };
        MRT_SwitchItemNextClass = "rhs_acc_2dpZenit";
        MRT_SwitchItemPrevClass = "a3aa_rhs_acc_2dpZenit_far";
        MRT_switchItemHintText = "Mode: Near";
    };
    class a3aa_rhs_acc_2dpZenit_far : rhs_acc_2dpZenit {
        scope = 1;
        class ItemInfo : ItemInfo {
            class FlashLight {
                FLASHLIGHT_VANILLA_AFRF_DEFAULTS
                ACE_FLASHLIGHT_PARAMS
                FLASHLIGHT_FAR
            };
        };
        MRT_SwitchItemNextClass = "a3aa_rhs_acc_2dpZenit_near";
        MRT_SwitchItemPrevClass = "rhs_acc_2dpZenit";
        MRT_switchItemHintText = "Mode: Far";
    };

    /*
     * RHS USAF - AN/PEQ-15
     * - since this already uses some custom RHS laser/light switching,
     *   don't configure CBA rail items for it, just set flashlight params
     */
    class acc_pointer_IR;
    class rhsusf_acc_anpeq15 : acc_pointer_IR {
        class ItemInfo;
    };
    class rhsusf_acc_anpeq15_light : rhsusf_acc_anpeq15 {
        class ItemInfo : ItemInfo {
            class Flashlight {
                FLASHLIGHT_VANILLA_DEFAULTS
                ACE_FLASHLIGHT_PARAMS
                FLASHLIGHT_MIDRANGE
            };
        };
    };
};

class SlotInfo;
class rhs_russian_ak_barrel_slot : SlotInfo {
    class compatibleItems {
        a3aa_rhs_acc_2dpZenit_near = 1;
        a3aa_rhs_acc_2dpZenit_far = 1;
    };
};
class rhs_russian_ris_side_slot : SlotInfo {
    class compatibleItems {
        a3aa_rhs_acc_2dpZenit_near = 1;
        a3aa_rhs_acc_2dpZenit_far = 1;
    };
};
class asdg_SlotInfo;
class asdg_FrontSideRail : asdg_SlotInfo {
    class compatibleItems {
        a3aa_rhs_acc_2dpZenit_near = 1;
        a3aa_rhs_acc_2dpZenit_far = 1;
    };
};
