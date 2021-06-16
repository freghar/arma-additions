/*
 * easy keybind access to Arsenal (or ACE Arsenal) for a logged in
 * or voted admin, optionally for anyone with Curator access
 */
class CfgPatches {
    class a3aa_insta_arsenal {
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
    class a3aa_insta_arsenal {
        class all {
            file = "\a3aa\insta_arsenal";
            class init;
            class arsenal;
            class allowed;
        };
    };
};

class Extended_PreInit_EventHandlers {
    class a3aa_insta_arsenal {
        init = "[] call a3aa_insta_arsenal_fnc_init";
    };
};
