class CfgPatches {
    class a3aa_ee_shared;
    class a3aa_ee_paper_map {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = { "a3aa_ee_shared" };
        addonRootClass = "a3aa_ee_shared";
    };
};

class CfgFunctions {
    class a3aa_ee_paper_map {
        class all {
            file = "\a3aa\ee\paper_map";
            class init;
            class onClients;
        };
    };
};

class CfgVehicles {
    class Logic;
    class a3aa_ee_shared_module_base : Logic {
        class EventHandlers;
    };
    class a3aa_ee_paper_map : a3aa_ee_shared_module_base {
        scope = 2;
        icon = "\A3\modules_f\data\portraitStrategicMapInit_ca.paa";
        displayName = "Paper map";
        class Attributes {
            class a3aa_ee_paper_map_markrange {
                property = "a3aa_ee_paper_map_markrange";
                control = "EditShort";
                displayName = "Marker sharing range";
                expression = "_this setVariable [""%s"",_value]";
                typeName = "NUMBER";
                defaultValue = "20";
                tooltip = "Maximum range in meters across which markers can be shared.";
            };
            class a3aa_ee_paper_map_nodelete {
                property = "a3aa_ee_paper_map_nodelete";
                control = "Checkbox";
                displayName = "Prevent marker deletion";
                expression = "_this setVariable [""%s"",_value]";
                defaultValue = "false";
                tooltip = "Disable the ""delete"" key on the map, simulating a true paper map. You might also want to disable ACE map marker moving (ace_markers_moveRestriction).";
            };
        };
        class EventHandlers : EventHandlers {
            class a3aa_ee_paper_map { init = "if (isServer) then { (_this select 0) call a3aa_ee_paper_map_fnc_init }"; };
        };
    };
};
