class CfgPatches {
    class a3aa_ee_locality_transfer {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {"a3aa_ee_shared"};
    };
};

class CfgFunctions {
    class a3aa_ee_locality_transfer {
        class all {
            file = "\a3aa\ee\locality_transfer";
            class setup;
            class getAllHCs;
            class areHCsReady;
            class getSuitableHC;
            class statisticsLoop;
            class updateHCInfo;
        };
    };
};

class Cfg3DEN {
    class Group {
        class AttributeCategories {
            class State {
                class Attributes {
                    class a3aa_ee_locality_transfer_exclude {
                        property = "a3aa_ee_locality_transfer_exclude";
                        control = "Checkbox";
                        displayName = "Don't transfer to HC";
                        expression = "_this setVariable [""%s"",_value]";
                        defaultValue = "false";
                        tooltip = "If the Locality Transfer module is placed, prevent this group from being transferred\n\nUseful if you have some scripting attached to it.";
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
            class a3aa_ee_locality_transfer_structured_hint {
                property = "a3aa_ee_locality_transfer_structured_hint";
                control = "StructuredText3";
                description = "Hint: This module transfers AI groups to headless clients (HCs). Both mission-placed and dynamically spawned (ie. from Zeus) groups are transferred. This can be disabled on a per-group basis in group attributes.";
            };
            class a3aa_ee_locality_transfer_wait_between {
                property = "a3aa_ee_locality_transfer_wait_between";
                control = "EditShort";
                displayName = "Wait between transfers";
                expression = "_this setVariable [""%s"",_value]";
                defaultValue = "3";
                typeName = "NUMBER";
                tooltip = "How many seconds to wait between group locality transfers. Increase to 15 or more if you have cba_network_loadoutValidation disabled, otherwise some soldiers might lose parts of their loadout (and/or appear naked) - known long-standing BI bug.\n\nIf set to 0, waiting for transfer completion still happens (only 1 transfer ongoing at a time), but no extra delay is inserted.";
            };
            class a3aa_ee_locality_transfer_delay_after_spawn {
                property = "a3aa_ee_locality_transfer_delay_after_spawn";
                control = "EditShort";
                displayName = "Delay after spawn";
                expression = "_this setVariable [""%s"",_value]";
                defaultValue = "20";
                typeName = "NUMBER";
                tooltip = "How many seconds to wait after a unit/group creation, before it is considered for a transfer. Setting it too low (0) causes glitches like drivers leaving vehicles (because Arma), setting it too high may be annoying to GMs (needing to wait). The default 20 seconds give a GM enough time to ie. drag a freshly spawned airplane into the air (where it continues to fly) without being too annoying of a delay.\n\nNote that this is a *minimum* guaranteed delay, the realistic delay will depend on server load and amount of groups to be transfered.";
            };
            class a3aa_ee_locality_transfer_distribute {
                property = "a3aa_ee_locality_transfer_distribute";
                control = "Combo";
                displayName = "Distribution logic";
                expression = "_this setVariable [""%s"",_value]";
                class Values {
                    class GroupCnt { name = "Fewest owned groups"; value = 0; };
                    class FPS { name = "Highest FPS"; value = 1; };
                };
                typeName = "NUMBER";
                defaultValue = "0";
                tooltip = "How to decide which HC (out of >1) to select as transfer destination.\nFewest groups is a reasonable default, but FPS-based distribution is useful in cases where ie. some (ambient) AI groups are always in combat and one HC out of two would always end up much more overloaded when using a group count logic.";
            };
            class a3aa_ee_locality_transfer_server_fallback {
                property = "a3aa_ee_locality_transfer_server_fallback";
                control = "Checkbox";
                displayName = "Use Server if no HCs exist";
                expression = "_this setVariable [""%s"",_value]";
                defaultValue = "true";
                tooltip = "If no headless clients are present, use the server as transfer destination. This is useful to get groups off the (potentially high ping) player clients, but will put extra load on the server process from simulating those groups.";
            };
            class a3aa_ee_locality_transfer_statistics {
                property = "a3aa_ee_locality_transfer_statistics";
                control = "Checkbox";
                displayName = "Record statistics on map";
                expression = "_this setVariable [""%s"",_value]";
                defaultValue = "true";
                tooltip = "If enabled, write current FPS values for server and all HCs at the bottom of the map screen, for debugging.";
            };
        };
        class EventHandlers : EventHandlers {
            class a3aa_ee_locality_transfer { init = "if (isServer) then { (_this select 0) call a3aa_ee_locality_transfer_fnc_setup }"; };
        };
    };
};
