/*
 * bright flashlight - a more reasonable weapon light source
 */

class CfgPatches {
    class a3aa_mtc_bright_flashlight {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {
            "A3_Weapons_F_Acc"
        };
        addonRootClass = "A3_Weapons_F_Acc";
    };
};

#include "flashlight_params.h"

class CfgWeapons {
    class ItemCore;
    class InventoryFlashLightItem_Base_F;
    class acc_flashlight : ItemCore {
        class ItemInfo : InventoryFlashLightItem_Base_F {
            class Flashlight {
                FLASHLIGHT_MIDRANGE
            };
        };
        MRT_SwitchItemNextClass = "a3aa_mtc_bright_flashlight_acc_flashlight_far";
        MRT_SwitchItemPrevClass = "a3aa_mtc_bright_flashlight_acc_flashlight_near";
        MRT_switchItemHintText = "Mode: Standard";
    };
    /*
     * the engine doesn't like inheritance in class Flashlight
     * and will render the flashlight useless
     * - just copy/paste vanilla defaults and add our customized values
     */
    class a3aa_mtc_bright_flashlight_acc_flashlight_near : acc_flashlight {
        scope = 1;
        displayName = "Flashlight (mode: near)";
        class ItemInfo : ItemInfo {
            class Flashlight {
                FLASHLIGHT_VANILLA_DEFAULTS
                FLASHLIGHT_NEAR
            };
        };
        MRT_SwitchItemNextClass = "acc_flashlight";
        MRT_SwitchItemPrevClass = "a3aa_mtc_bright_flashlight_acc_flashlight_far";
        MRT_switchItemHintText = "Mode: Near";
    };
    class a3aa_mtc_bright_flashlight_acc_flashlight_far : acc_flashlight {
        scope = 1;
        displayName = "Flashlight (mode: far)";
        class ItemInfo : ItemInfo {
            class Flashlight {
                FLASHLIGHT_VANILLA_DEFAULTS
                FLASHLIGHT_FAR
            };
        };
        MRT_SwitchItemNextClass = "a3aa_mtc_bright_flashlight_acc_flashlight_near";
        MRT_SwitchItemPrevClass = "acc_flashlight";
        MRT_switchItemHintText = "Mode: Far";
    };
};

class PointerSlot;
class PointerSlot_Rail : PointerSlot {
    class compatibleItems {
        a3aa_mtc_bright_flashlight_acc_flashlight_near = 1;
        a3aa_mtc_bright_flashlight_acc_flashlight_far = 1;
    };
};

class asdg_SlotInfo;
class asdg_FrontSideRail : asdg_SlotInfo {
    class compatibleItems {
        a3aa_mtc_bright_flashlight_acc_flashlight_near = 1;
        a3aa_mtc_bright_flashlight_acc_flashlight_far = 1;
    };
};
