class CfgPatches {
    class a3aa_ee_remove_ace_eh {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {"a3aa_ee_shared"};
    };
};

class CfgFunctions {
    class a3aa_ee_remove_ace_eh {
        class all {
            file = "\a3aa\ee\remove_ace_eh";
            class parse;
            class setupClassEH;
        };
    };
};

class CfgVehicles {
    class Logic;
    class a3aa_ee_shared_module_base : Logic {
        class EventHandlers;
    };
    class a3aa_ee_remove_ace_eh : a3aa_ee_shared_module_base {
        scope = 2;
        icon = "\a3\Ui_f\data\IGUI\Cfg\Revive\overlayIcons\u100_ca.paa";
        displayName = "Remove ACE Medical EH";
        class Attributes {
            class a3aa_ee_remove_ace_eh_structured_hint {
                property = "a3aa_ee_kill_on_jip_structured_hint";
                control = "StructuredText4";
                description = "Hint: This module allows you to bypass ACE Medical EventHandler (SQF code that handles incoming damage) and lets the game engine handle the damage done to units. This may result in less glitches, but will feel more like vanilla game (ie. destroyed vehicles will kill units inside, Heal vanilla interaction menu action on taking damage, etc.).";
            };
            class a3aa_ee_remove_ace_eh_cond {
                property = "a3aa_ee_remove_ace_eh_cond";
                control = "EditCodeMulti3";
                displayName = "Condition";
                expression = "_this setVariable [""%s"",_value]";
                defaultValue = """true""";
                typeName = "STRING";
                tooltip = "Custom condition selecting which units the removal should apply to. If 'true', the EH is removed from all soldiers (incl. players). The soldier unit is passed as _this.\n\nExamples:\n\nAI only (keep EH for AI in lobby slots):\n!(_this in playableUnits)\n\nAnything hostile to the 'west' side (BLUFOR):\nside _this getFriend west < 0.6\n\nAny AI units except for one VIP:\n!(_this in playableUnits) && _this != somevipunit\n\nAny AI hostile to players (assuming all players share one side):\n!(_this in playableUnits) && side _this getFriend side (allPlayers#0) < 0.6\n";
            };
        };
        class EventHandlers : EventHandlers {
            class a3aa_ee_remove_ace_eh { init = "if (isServer) then { (_this select 0) call a3aa_ee_remove_ace_eh_fnc_parse }"; };
        };
    };
};
