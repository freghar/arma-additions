class CfgPatches {
    class a3aa_grasskeys {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {
            "a3aa_functions",
            "cba_keybinding",
            "cba_settings",
            "cba_xeh"
        };
    };
};

class CfgFunctions {
    class a3aa_grasskeys {
        class all {
            file = "\a3aa\grasskeys";
            class init;
            class setTerrain;
        };
    };
};

class Extended_PreInit_EventHandlers {
    class a3aa_grasskeys {
        init = "[] call a3aa_grasskeys_fnc_init";
    };
};
