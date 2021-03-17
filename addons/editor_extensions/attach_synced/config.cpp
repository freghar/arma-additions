class CfgPatches {
    class a3aa_ee_shared;
    class a3aa_ee_attach_synced {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {"a3aa_ee_shared"};
        addonRootClass = "a3aa_ee_shared";
    };
};

class CfgFunctions {
    class a3aa_ee_attach_synced {
        class all {
            file = "\a3aa\ee\attach_synced";
            class attach;
        };
    };
};

class CfgVehicles {
    class Logic;
    class a3aa_ee_shared_module_base : Logic {
        class EventHandlers;
    };
    class a3aa_ee_attach_synced : a3aa_ee_shared_module_base {
        scope = 2;
        icon = "\a3\Modules_F\Data\iconTaskCreate_ca.paa";
        displayName = "Attach synced";
        class Attributes {
            class a3aa_ee_attach_synced_structured_hint {
                property = "a3aa_ee_attach_synced_structured_hint";
                control = "StructuredText2";
                description = "Hint: First, synchronize the the object/unit you want everything else to attach to with this module. Then, synchronize all of the other objects/units you want to attach.";
            };
        };
        class EventHandlers : EventHandlers {
            class a3aa_ee_attach_synced { init = "if (isServer) then { (_this select 0) call a3aa_ee_attach_synced_fnc_attach }"; };
        };
    };
};
