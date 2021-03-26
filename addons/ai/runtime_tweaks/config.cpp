class CfgPatches {
    class a3aa_ai_runtime_tweaks {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {
            "cba_settings",
            "cba_events",
            "cba_xeh"
        };
    };
};

class CfgFunctions {
    class a3aa_ai_runtime_tweaks {
        class all {
            file = "\a3aa\ai\runtime_tweaks";
            class init;
        };
    };
};

class Extended_PreInit_EventHandlers {
    class a3aa_ai_runtime_tweaks {
        init = "[] call a3aa_ai_runtime_tweaks_fnc_init";
    };
};
