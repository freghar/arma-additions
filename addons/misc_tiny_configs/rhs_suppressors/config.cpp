/*
 * rhs supressors - loudness tweaks to suppressors
 */

class CfgPatches {
    class a3aa_mtc_rhs_suppressors {
        units[] = {};
        weapons[] = {};
        magazines[] = {};
        requiredAddons[] = {
            "a3aa_mtc_suppressors",
            "rhsusf_c_weapons",  /* rhsusf_silencer_base */
            "rhs_c_weapons"      /* rhs_silencer_base */
        };
        addonRootClass = "rhsusf_c_weapons";
    };
};


class CfgWeapons {
    class muzzle_snds_H;
    class InventoryMuzzleItem_Base_F;

    /* RHS US suppressors in general; equivalent to 6.5mm from silent_ops */
    class rhsusf_silencer_base : muzzle_snds_H {
        class ItemInfo : InventoryMuzzleItem_Base_F {
            class AmmoCoef {
                /* ~10m */
                audibleFire = 0.005;
                visibleFire = 0.005;
            };
        };
    };

    /* RHS AFRF suppressors */
    class rhs_silencer_base : muzzle_snds_H {
        class ItemInfo : InventoryMuzzleItem_Base_F {
            class AmmoCoef {
                /* ~10m */
                audibleFire = 0.005;
                visibleFire = 0.005;
            };
        };
    };

};
