class CfgPatches {
    class a3aa_ai_dynamic_skill {
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
    class a3aa_ai_dynamic_skill {
        class all {
            file = "\a3aa\ai\dynamic_skill";
            class init;
            class initUnit;
            class updateUnit;
        };
        class helpers {
            file = "\a3aa\ai\dynamic_skill\helpers";
            class getSkills;
            class setSkills;
            class hasDefaultSkills;
        };
        class presets {
            file = "\a3aa\ai\dynamic_skill\presets";
            class presetHard;
            class presetEasy;
            class presetStaticVanilla;
            class isGuerrilla;
        };
    };
};

class Extended_PreInit_EventHandlers {
    class a3aa_ai_dynamic_skill {
        init = "[] call a3aa_ai_dynamic_skill_fnc_init";
    };
};
