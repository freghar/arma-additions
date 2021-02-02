class CfgPatches {
    class a3aa_ai_crew_in_immobile {
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
    class a3aa_ai_crew_in_immobile {
        class all {
            file = "\a3aa\ai\crew_in_immobile";
            class init;
        };
    };
};

class Extended_PreInit_EventHandlers {
    class a3aa_ai_crew_in_immobile {
        init = "[] call a3aa_ai_crew_in_immobile_fnc_init";
    };
};
