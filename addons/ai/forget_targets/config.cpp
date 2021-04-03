class CfgPatches {
    class a3aa_ai_forget_targets {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {
            "a3aa_functions",
            "cba_settings",
            "cba_events",
            "cba_xeh"
        };
    };
};

class CfgFunctions {
    class a3aa_ai_forget_targets {
        class all {
            file = "\a3aa\ai\forget_targets";
            class init;
        };
    };
};

class Extended_PreInit_EventHandlers {
    class a3aa_ai_forget_targets {
        init = "[] call a3aa_ai_forget_targets_fnc_init";
    };
};
