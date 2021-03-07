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
        class all {
            file = "\a3aa\insta_zeus";
            class mkCurator;
            class mkCuratorAddEHs;
            class createAdminCurator { postInit = 1; };
            class createUnitCurator;
            class respawnCurator { preInit = 1; };
            class addPlayers { postInit = 1; };
        };
    };
};

class CfgVehicles {
    /* inherit ModuleCurator_F so other mods can add CBA class EH on it */
    class ModuleCurator_F;
    class a3aa_insta_zeus_dumb_curator : ModuleCurator_F {
        scope = 1;
        function = "";
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
