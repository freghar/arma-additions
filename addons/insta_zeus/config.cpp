class CfgPatches {
    class a3aa_insta_zeus {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {
            "3den",
            "cba_xeh"
        };
    };
};

class CfgFunctions {
    class a3aa_insta_zeus {
        /* instance dedicated to logged in / voted admin */
        class admin_curator {
            file = "\a3aa\insta_zeus\admin_curator";
            class createGlobalCurator { postInit = 1; };
            class maintainCurator { postInit = 1; };
        };
        /* checkbox-based (Eden) per-unit curator instances */
        class unit_curator {
            file = "\a3aa\insta_zeus\unit_curator";
            class createUnitCurator;
        };
        /* misc keepers for all curators */
        class runtime {
            file = "\a3aa\insta_zeus\runtime";
            class addPlayer { postInit = 1; };
            class onRespawn { postInit = 1; };
        };
        /* internal and external */
        class api {
            file = "\a3aa\insta_zeus\api";
            class mkCurator;
            class curatorOpened;
        };
    };
};

class CfgVehicles {
    class Logic;
    class a3aa_insta_zeus_dumb_curator : Logic {
        scope = 1;
        /* creates a curator instance upon creating this Vehicle */
        simulation = "curator";
    };
};

class Cfg3DEN {
    class Object {
        class AttributeCategories {
            class Control {
                class Attributes {
                    class a3aa_insta_zeus_unit_curator {
                        property = "a3aa_insta_zeus_unit_curator";
                        control = "Checkbox";
                        displayName = "Create Zeus for this unit";
                        expression = "[_this, _value] call a3aa_insta_zeus_fnc_createUnitCurator";
                        condition = "objectBrain";
                        defaultValue = "false";
                        tooltip = "Create a new Curator instance and assign it to the unit.\nWorks only in Multiplayer (global admin Curator instance is used in SP regardless).";
                    };
                };
            };
        };
    };
};
