/*
 * suppressors - miscellaneous tweaks to vanilla suppressors to make them
 * more reasonably quiet
 */

class CfgPatches {
    class a3aa_mtc_suppressors {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {
            "A3_Weapons_F",
            "A3_Weapons_F_Acc",
            "A3_Weapons_F_Mark_Acc",
            "A3_Weapons_F_Exp",
            "A3_Weapons_F_Mod"
        };
    };
};

class CfgAmmo {
    /* silent grenade throwing, AI still hears explosion */
    class Grenade;
    class GrenadeHand : Grenade {
        audibleFire = 0.005;
        visibleFire = 0.001;
    };
};

#define SNDS_CFG(inherits, value) \
    class ItemInfo : inherits { \
        class AmmoCoef { \
            audibleFire = value; \
            visibleFire = value; \
        }; \
    }

#define SNDS_CFG_CHILD(inherits, value) \
    class ItemInfo : inherits { \
        class AmmoCoef : AmmoCoef { \
            audibleFire = value; \
            visibleFire = value; \
        }; \
    }

/*
 * distances are for open ground and two Rifleman units and weapons that would
 * be considered "typical" for the calibers used
 * (the values are modifiers of CfgAmmo loudness)
 */

#define VERYLOUD   0.02    /* ~52m */
#define LOUD       0.01    /* ~27m */
#define AVERAGE    0.007   /* ~21m */
#define QUIET      0.003   /* ~18m */
#define VERYQUIET  0.0001  /* ~1m */

class CfgWeapons {
    class ItemCore;
    class InventoryMuzzleItem_Base_F;

    /* 9.3mm */
    class muzzle_snds_93mmg : ItemCore {
        SNDS_CFG(InventoryMuzzleItem_Base_F, VERYLOUD);
    };
    /* 8.6mm (.338) */
    class muzzle_snds_338_black : ItemCore {
        SNDS_CFG(InventoryMuzzleItem_Base_F, VERYLOUD);
    };
    /* 6.5mm & some others inheriting */
    class muzzle_snds_H : ItemCore {
        SNDS_CFG(InventoryMuzzleItem_Base_F, AVERAGE);
    };
    /* 6.5mm MG */
    class muzzle_snds_H_MG : muzzle_snds_H {
        SNDS_CFG(ItemInfo, AVERAGE);
    };
    class muzzle_snds_H_SW : muzzle_snds_H_MG {
        SNDS_CFG(ItemInfo, AVERAGE);
    };
    /* 7.62mm */
    class muzzle_snds_B : muzzle_snds_H {
        SNDS_CFG(ItemInfo, LOUD);
    };
    /* 5.56mm */
    class muzzle_snds_M : muzzle_snds_H {
        SNDS_CFG(ItemInfo, QUIET);
    };
    /* 9mm */
    class muzzle_snds_L : muzzle_snds_H {
        SNDS_CFG(ItemInfo, VERYQUIET);
    };
    /* .45 ACP same as 9mm */
    class muzzle_snds_acp : muzzle_snds_H {
        SNDS_CFG(ItemInfo, VERYQUIET);
    };
    /* 5.7mm (P90) same as 9mm */
    class muzzle_snds_570 : ItemCore {
        SNDS_CFG(InventoryMuzzleItem_Base_F, VERYQUIET);
    };
    /* 6.5mm "stealth" and 5.8mm - same as 6.5mm */
    class muzzle_snds_65_TI_blk_F : muzzle_snds_M {
        SNDS_CFG_CHILD(ItemInfo, AVERAGE);
    };
    class muzzle_snds_58_blk_F : muzzle_snds_M {
        SNDS_CFG_CHILD(ItemInfo, AVERAGE);
    };
};
