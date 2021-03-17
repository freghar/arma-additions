class CfgPatches {
    class a3aa_ee_shared;
    class a3aa_ee_locality_transfer {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {"a3aa_ee_shared"};
        addonRootClass = "a3aa_ee_shared";
    };
};

class CfgFunctions {
    class a3aa_ee_locality_transfer {
        class all {
            file = "\a3aa\ee\locality_transfer";
            class transfer;
        };
    };
};

class Cfg3DEN {
    class Group {
        class AttributeCategories {
            class State {
                class Attributes {
                    class a3aa_ee_locality_transfer {
                        property = "a3aa_ee_locality_transfer";
                        control = "Checkbox";
                        displayName = "Move group to HC";
                        expression = "_this setVariable [""%s"",_value]";
                        defaultValue = "false";
                        tooltip = "Transfer this group to a Headless Client before mission start, but after any unit/group initialization finishes.\nNote that any changes with local effect will be lost.\n\nThis functionality needs a module counterpart.";
                    };
                };
            };
        };
    };
};

class CfgVehicles {
    class Logic;
    class a3aa_ee_shared_module_base : Logic {
        class EventHandlers;
    };
    class a3aa_ee_locality_transfer : a3aa_ee_shared_module_base {
        scope = 2;
        icon = "iconVirtual";
        displayName = "Locality transfer (to HC)";
        class Attributes {
            class a3aa_ee_locality_transfer_hcs_required {
                property = "a3aa_ee_locality_transfer_hcs_required";
                control = "EditShort";
                displayName = "Require HCs";
                expression = "_this setVariable [""%s"",_value]";
                defaultValue = "1";
                typeName = "NUMBER";
                tooltip = "How many HCs should we wait for on the map briefing screen before starting group redistribution - if this amount of HCs isn't reached before the mission start, the transfer is aborted.";
            };
            class a3aa_ee_locality_transfer_structured_hint {
                property = "a3aa_ee_locality_transfer_structured_hint";
                control = "StructuredText2";
                description = "Hint: This module does the actual transfer, but you still need to pick which groups to transfer in group attributes.";
            };
        };
        class EventHandlers : EventHandlers {
            class a3aa_ee_locality_transfer { init = "if (isServer) then { (_this select 0) call a3aa_ee_locality_transfer_fnc_transfer }"; };
        };
    };
};
