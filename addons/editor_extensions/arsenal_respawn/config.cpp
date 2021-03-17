class CfgPatches {
    class a3aa_ee_shared;
    class a3aa_ee_arsenal_respawn {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {"a3aa_ee_shared"};
        addonRootClass = "a3aa_ee_shared";
    };
};

class CfgFunctions {
    class a3aa_ee_arsenal_respawn {
        class all {
            file = "\a3aa\ee\arsenal_respawn";
            class setupRespawn;
            class acreFixRadios;
        };
    };
};

class CfgVehicles {
    class Logic;
    class a3aa_ee_shared_module_base : Logic {
        class EventHandlers;
    };
    class a3aa_ee_aresenal_respawn : a3aa_ee_shared_module_base {
        scope = 2;
        icon = "\a3\Modules_f\data\portraitRespawn_ca.paa";
        displayName = "Arsenal Respawn";
        class Attributes {
            class structured_hint {
                property = "a3aa_ee_arsenal_respawn_structured_hint";
                control = "StructuredText1";
                description = "Hint: This module allows units with Arsenal loadouts respawn with those pre-defined loadouts.";
            };
        };
        class EventHandlers : EventHandlers {
            class a3aa_ee_arsenal_respawn { init = "(_this select 0) call a3aa_ee_arsenal_respawn_fnc_setupRespawn"; };
        };
    };
};
