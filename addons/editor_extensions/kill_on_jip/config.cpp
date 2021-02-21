class CfgPatches {
    class a3aa_ee_kill_on_jip {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {"a3aa_ee_shared"};
    };
};

class CfgFunctions {
    class a3aa_ee_kill_on_jip {
        class all {
            file = "\a3aa\ee\kill_on_jip";
            class parse;
            class kill;
        };
    };
};

class CfgVehicles {
    class Logic;
    class a3aa_ee_shared_module_base : Logic {
        class EventHandlers;
    };
    class a3aa_ee_kill_on_jip : a3aa_ee_shared_module_base {
        scope = 2;
        icon = "iconMan";
        displayName = "Kill player on JIP";
        class Attributes {
            class a3aa_ee_kill_on_jip_structured_hint {
                property = "a3aa_ee_kill_on_jip_structured_hint";
                control = "StructuredText2";
                description = "Hint: Simply kill players who Join In Progress. Good for PvP in combination with spectator-on-death for one-life PvP missions.";
            };
        };
        class EventHandlers : EventHandlers {
            class a3aa_ee_kill_on_jip { init = "if (isServer) then { (_this select 0) call a3aa_ee_kill_on_jip_fnc_parse }"; };
        };
    };
};
