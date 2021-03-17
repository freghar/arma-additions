class CfgPatches {
    class a3aa_ee_shared;
    class a3aa_ee_playable_ai {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = { "a3aa_ee_shared" };
        addonRootClass = "a3aa_ee_shared";
    };
};

class CfgFunctions {
    class a3aa_ee_playable_ai {
        class all {
            file = "\a3aa\ee\playable_ai";
            class registerEH;
        };
    };
};

class CfgVehicles {
    class Logic;
    class a3aa_ee_shared_module_base : Logic {
        class EventHandlers;
    };
    class a3aa_ee_playable_ai : a3aa_ee_shared_module_base {
        scope = 2;
        icon = "\a3\Modules_F_Curator\Data\portraitAnimals_ca.paa";
        displayName = "Keep Playable AI";
        class Attributes {
            class a3aa_ee_playable_ai_stop_ai {
                property = "a3aa_ee_playable_ai_stop_ai";
                control = "Checkbox";
                displayName = "Stop AI";
                expression = "_this setVariable [""%s"",_value]";
                defaultValue = "true";
                tooltip = "Order the AI to stop, hold fire, go prone and generally be passive to avoid exposing the players to danger instead of trying to play/follow along. Can be overruled by group leader using AI commands.";
            };
            class a3aa_ee_playable_ai_custom_code {
                property = "a3aa_ee_playable_ai_custom_code";
                control = "EditCodeMulti3";
                displayName = "Code";
                expression = "_this setVariable [""%s"",_value]";
                defaultValue = """""";
                typeName = "STRING";
                tooltip = "Custom code to run (on server) on the AI unit when a player disconnects.";
            };
        };
        class EventHandlers : EventHandlers {
            class a3aa_ee_playable_ai { init = "if (isServer) then { (_this select 0) call a3aa_ee_playable_ai_fnc_registerEH }"; };
        };
    };
};
