class CfgPatches {
    class a3aa_ee_shared;
    class a3aa_ee_teleport_on_jip {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {"a3aa_ee_shared"};
        addonRootClass = "a3aa_ee_shared";
    };
};

class CfgFunctions {
    class a3aa_ee_teleport_on_jip {
        class all {
            file = "\a3aa\ee\teleport_on_jip";
            class parse;
            class teleport;
        };
    };
};

class CfgVehicles {
    class Logic;
    class a3aa_ee_shared_module_base : Logic {
        class EventHandlers;
    };
    class a3aa_ee_teleport_on_jip : a3aa_ee_shared_module_base {
        scope = 2;
        icon = "\a3\Missions_F_Curator\data\img\portraitMPTypeSectorControl_ca.paa";
        displayName = "Teleport on JIP";
        class EventHandlers : EventHandlers {
            class a3aa_ee_teleport_on_jip { init = "if (isServer) then { (_this select 0) call a3aa_ee_teleport_on_jip_fnc_parse }"; };
        };
    };
};
