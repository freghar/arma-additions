class CfgPatches {
    class a3aa_ee_insta_osd {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {"a3aa_ee_shared"};
    };
};

class CfgFunctions {
    class a3aa_ee_insta_osd {
        class all {
            file = "\a3aa\ee\insta_osd";
            class nearLocText;
            class moduleOSD;
            class moduleOSDClients;
            class typeText;
            class instaOSD;
        };
    };
};

class CfgVehicles {
    class Logic;
    class a3aa_ee_shared_module_base : Logic {
        class EventHandlers;
    };
    class a3aa_ee_insta_osd : a3aa_ee_shared_module_base {
        scope = 2;
        icon = "\A3\modules_f\data\portraitStrategicMapMission_ca.paa";
        displayName = "Insta OSD Location Info";
        class Attributes {
            class a3aa_ee_insta_osd_header {
                property = "a3aa_ee_insta_osd_header";
                control = "Edit";
                displayName = "Custom header";
                expression = "_this setVariable [""%s"",_value]";
                typeName = "STRING";
                defaultValue = """""";
                tooltip = "Displayed in bold above the location info. If unset, no header is displayed.\n\nGood for ie. mission name.";
            };
            class a3aa_ee_insta_osd_tojip {
                property = "a3aa_ee_insta_osd_tojip";
                control = "Checkbox";
                displayName = "Show to JIP players";
                expression = "_this setVariable [""%s"",_value]";
                defaultValue = "false";
            };
        };
        class EventHandlers : EventHandlers {
            class a3aa_ee_insta_osd { init = "if (isServer) then { (_this select 0) call a3aa_ee_insta_osd_fnc_moduleOSD }"; };
        };
    };
};
