/*
 * some mods add custom magazines / rocket ammo / etc. into various boxes
 * and vehicles, even those outside of their mod(s) - worse yet, they do it
 * via init EHs, so one can't just override this via configs
 * - as a last resort, wait a short while after each vehicle init and clear
 *   its inventory completely, replacing it with some basic universal loot
 */

class CfgPatches {
    class a3aa_ee_shared;
    class a3aa_ee_basic_vehicle_cargo {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {
            "a3aa_ee_shared",
            "cba_settings",
            "cba_events",
            "cba_xeh"     /* dynamic class hook from module */
        };
        addonRootClass = "a3aa_ee_shared";
    };
};

class CfgFunctions {
    class a3aa_ee_basic_vehicle_cargo {
        class all {
            file = "\a3aa\ee\basic_vehicle_cargo";
            class hookClasses;
            class setCargo;
            class init;
        };
    };
};

class Extended_PreInit_EventHandlers {
    class a3aa_ee_basic_vehicle_cargo {
        init = "[] call a3aa_ee_basic_vehicle_cargo_fnc_init";
    };
};

class CfgVehicles {
    class Logic;
    class a3aa_ee_shared_module_base : Logic {
        class EventHandlers;
    };
    class a3aa_ee_basic_vehicle_cargo : a3aa_ee_shared_module_base {
        scope = 2;
        icon = "iconCrateWpns";
        displayName = "Basic vehicle cargo";
        class EventHandlers : EventHandlers {
            class a3aa_ee_basic_vehicle_cargo { init = "if (!is3DEN) then { (_this select 0) spawn a3aa_ee_basic_vehicle_cargo_fnc_hookClasses }"; };
        };
    };
};

class Cfg3DEN {
    class Object {
        class AttributeCategories {
            class StateSpecial {
                class Attributes {
                    class a3aa_ee_basic_vehicle_cargo_dontclear {
                        property = "a3aa_ee_basic_vehicle_cargo_dontclear";
                        control = "Checkbox";
                        displayName = "Don't clear vehicle cargo";
                        expression = "_this setVariable [""%s"",_value,true]";
                        condition = "objectHasInventoryCargo";
                        defaultValue = "false";
                        tooltip = "When the 'Basic Vehicle Cargo' module is present, all inventories of vehicles are wiped after their 'init' scripts run. This prevents mission makers from specifying loadout via Eden UI. Use this option to disable the functionality.";
                    };
                };
            };
        };
    };
};
