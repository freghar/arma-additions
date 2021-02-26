class CfgPatches {
    class a3aa_ee_stay_and_watch {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {"a3aa_ee_shared"};
    };
};

class CfgFunctions {
    class a3aa_ee_stay_and_watch {
        class all {
            file = "\a3aa\ee\stay_and_watch";
            class parse;
        };
    };
};

class CfgVehicles {
    class Logic;
    class a3aa_ee_shared_module_base : Logic {
        class EventHandlers;
    };
    class a3aa_ee_stay_and_watch : a3aa_ee_shared_module_base {
        scope = 2;
        icon = "\A3\Ui_f\data\IGUI\Cfg\simpleTasks\types\defend_ca.paa";
        displayName = "Stay and watch";
        class Attributes {
            class a3aa_ee_stay_and_watch_structured_hint {
                property = "a3aa_ee_kill_on_jip_structured_hint";
                control = "StructuredText3";
                description = "Hint: This makes synchronized units (and units on a specific Eden editor layer specified below) always stay in place (via disableAI ""PATH"") and tells them to watch a direction they were rotated to in the editor.";
            };
            class a3aa_ee_stay_and_watch_layer {
                property = "a3aa_ee_stay_and_watch_layer";
                control = "Edit";
                displayName = "Editor Layer";
                expression = "_this setVariable [""%s"",_value]";
                defaultValue = """""";
                typeName = "STRING";
                tooltip = "The module will have an effect on any units on this Eden editor layer\n(in addition to synchronized units, if there are any).";
            };
        };
        class EventHandlers : EventHandlers {
            class a3aa_ee_stay_and_watch { init = "if (isServer) then { (_this select 0) call a3aa_ee_stay_and_watch_fnc_parse }"; };
        };
    };
};
