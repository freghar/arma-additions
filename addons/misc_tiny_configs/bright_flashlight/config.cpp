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

class CfgWeapons {
    /* weapon-attached flashlight */
    class ItemCore;
    class InventoryFlashLightItem_Base_F;
    class acc_flashlight: ItemCore {
        class ItemInfo: InventoryFlashLightItem_Base_F {
            class Flashlight {
                #include "flashlight_params.h"
            };
        };
    };
};
