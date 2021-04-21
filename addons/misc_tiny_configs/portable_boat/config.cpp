/*
 * simple Portable Boat that can be assembled/disassembled, single backpack
 */

class CfgPatches {
    class a3aa_mtc_portable_boat {
        units[] = { "a3aa_mtc_portable_boat_boat" };
        weapons[] = {};
        requiredAddons[] = {
            "A3_Static_F",
            "A3_Boat_F_Boat_Transport_01"
        };
    };
};

class CfgVehicles {
    class Rubber_duck_base_F;
    class B_Boat_Transport_01_F : Rubber_duck_base_F {
        class EventHandlers;
    };
    class a3aa_mtc_portable_boat_boat : B_Boat_Transport_01_F {
        scope = 2;
        displayName = "Portable Boat";
        class assembleInfo {
            primary = 1;
            base = "";
            assembleTo = "";
            displayName = "";
            dissasembleTo[] = {"a3aa_portable_boat_backpack"};
        };
        class EventHandlers : EventHandlers {
            class a3aa_mtc_portable_boat {
                /* turn the boat so it doesn't kill the player by collision */
                init = "(_this select 0) setDir (getDir (_this select 0) + 270)";
            };
        };
    };

    class Weapon_Bag_Base;
    class a3aa_portable_boat_backpack : Weapon_Bag_Base {
        scope = 2;
        displayName = "Portable Boat Bag";
        picture = "\A3\Drones_F\Weapons_F_Gamma\ammoboxes\bags\data\ui\icon_B_C_UAV_rgr_ca";
        model = "\A3\Drones_F\Weapons_F_Gamma\Ammoboxes\Bags\UAV_backpack_F.p3d";
        hiddenSelectionsTextures[] = {"\A3\Drones_F\Weapons_F_Gamma\Ammoboxes\Bags\data\UAV_backpack_rgr_co.paa"};
        maximumLoad = 0;
        mass = 300;  /* like UAV backpack */
        mapSize = 0.6;
        class assembleInfo {
            primary = 1;
            base = "";
            assembleTo = "a3aa_mtc_portable_boat_boat";
            displayName = "Portable Boat";
            dissasembleTo[] = {};
        };
    };
};

class CfgAddons {
    class PreloadAddons {
        class a3aa_mtc_portable_boat {
            list[] = { "a3aa_mtc_portable_boat" };
        };
    };
};
