class CfgPatches {
    class a3aa_chestpack {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {
            "cba_keybinding",
            "cba_events",
            "cba_xeh"
        };
    };
};

class CfgFunctions {
    class a3aa_chestpack {
        class all {
            file = "\a3aa\chestpack";
            /* preInit because of newControllableObject */
            class hookACEInteract { preInit = 1; };
            class hookCBAKeybind;
            class oneKeyAutoSwap;
            class isDead;
            class setChestpack;
            class removeChestpack;
            class setBackpack;
            class removeBackpack;
            class clearOnRespawn { postInit = 1; };
        };
    };
};

class Extended_PreInit_EventHandlers {
    class a3aa_chestpack {
        init = "[] call a3aa_chestpack_fnc_hookCBAKeybind";
    };
};
