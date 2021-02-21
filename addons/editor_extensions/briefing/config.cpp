class CfgPatches {
    class a3aa_ee_briefing {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {"a3aa_ee_shared"};
    };
};

class CfgFunctions {
    class a3aa_ee_briefing {
        class all {
            file = "\a3aa\ee\briefing";
            class parse;
            class makeDiaryEntries;
        };
    };
};

class CfgVehicles {
    class Logic;
    class a3aa_ee_shared_module_base : Logic {
        class EventHandlers;
    };
    class a3aa_ee_briefing : a3aa_ee_shared_module_base {
        scope = 2;
        icon = "\a3\Modules_f\data\portraitHQ_ca.paa";
        displayName = "Briefing (OPORD)";
        class Attributes {
            class a3aa_ee_briefing_briefingfor {
                property = "a3aa_ee_briefing_briefingfor";
                control = "Combo";
                displayName = "Briefing for";
                expression = "_this setVariable [""%s"",_value]";
                class Values {
                    class Everyone { name = "Everyone"; value = "everyone"; };
                    class Side_BLUFOR { name = "Side - BLUFOR"; value = "side_blufor"; };
                    class Side_OPFOR { name = "Side - OPFOR"; value = "side_opfor"; };
                    class Side_Indep { name = "Side - Independent"; value = "side_indep"; };
                    class Side_Civ { name = "Side - Civilian"; value = "side_civ"; };
                    /* synchronizedObjects doesn't work here, we would need to spawn + wait,
                    * but we can't know what to wait for, so this logic can't easily support
                    * briefings for synchronized players */
                    //class Synced { name = "Synchronized groups (non-JIP)"; value = "synced"; };
                };
                typeName = "STRING";
                defaultValue = """everyone""";
            };
            class a3aa_ee_briefing_situation {
                property = "a3aa_ee_briefing_situation";
                control = "a3aa_ee_EditBig15";
                displayName = "Situation";
                expression = "_this setVariable [""%s"",_value]";
                defaultValue = """""";
                typeName = "STRING";
            };
            class a3aa_ee_briefing_mission {
                property = "a3aa_ee_briefing_mission";
                control = "a3aa_ee_EditBig15";
                displayName = "Mission";
                expression = "_this setVariable [""%s"",_value]";
                defaultValue = """""";
                typeName = "STRING";
            };
            class a3aa_ee_briefing_execution {
                property = "a3aa_ee_briefing_execution";
                control = "a3aa_ee_EditBig15";
                displayName = "Execution";
                expression = "_this setVariable [""%s"",_value]";
                defaultValue = """""";
                typeName = "STRING";
            };
            class a3aa_ee_briefing_admin_logistics {
                property = "a3aa_ee_briefing_admin_logistics";
                control = "a3aa_ee_EditBig15";
                displayName = "Admin & Logistics";
                expression = "_this setVariable [""%s"",_value]";
                defaultValue = """""";
                typeName = "STRING";
            };
            class a3aa_ee_briefing_command_signal {
                property = "a3aa_ee_briefing_command_signal";
                control = "a3aa_ee_EditBig15";
                displayName = "Command & Signal";
                expression = "_this setVariable [""%s"",_value]";
                defaultValue = """""";
                typeName = "STRING";
            };
        };
        class EventHandlers : EventHandlers {
            class a3aa_ee_briefing { init = "if (isServer) then { (_this select 0) call a3aa_ee_briefing_fnc_parse }"; };
        };
    };
};
