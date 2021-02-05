class Logic;
class a3aa_ee_shared_module_base : Logic {
    class EventHandlers;
};

class a3aa_ee_custom_location : a3aa_ee_shared_module_base {
    scope = 2;
    icon = "\A3\modules_f\data\portraitStrategicMapOpen_ca.paa";
    displayName = "Custom Location";
    canSetArea = 1;
    class AttributeValues {
        size3[] = {40, 20, -1};
        IsRectangle = 1;
    };
    class Attributes {
        class a3aa_ee_custom_location_locname {
            property = "a3aa_ee_custom_location_locname";
            control = "Edit";
            displayName = "Name";
            expression = "_this setVariable [""%s"",_value]";
            typeName = "STRING";
            defaultValue = """""";
        };
        class a3aa_ee_custom_location_loctype {
            property = "a3aa_ee_custom_location_loctype";
            control = "Combo";
            displayName = "Type";
            expression = "_this setVariable [""%s"",_value]";
            class Values {
                class Airport { name = "Airport"; value = "Airport"; };
                class NameMarine { name = "NameMarine"; value = "NameMarine"; };
                class NameCityCapital { name = "NameCityCapital"; value = "NameCityCapital"; };
                class NameCity { name = "NameCity"; value = "NameCity"; };
                class NameVillage { name = "NameVillage"; value = "NameVillage"; };
                class NameLocal { name = "NameLocal"; value = "NameLocal"; };
                class Hill { name = "Hill"; value = "Hill"; };
                class ViewPoint { name = "ViewPoint"; value = "ViewPoint"; };
                class RockArea { name = "RockArea"; value = "RockArea"; };
                class BorderCrossing { name = "BorderCrossing"; value = "BorderCrossing"; };
                class VegetationBroadleaf { name = "VegetationBroadleaf"; value = "VegetationBroadleaf"; };
                class VegetationFir { name = "VegetationFir"; value = "VegetationFir"; };
                class VegetationPalm { name = "VegetationPalm"; value = "VegetationPalm"; };
                class VegetationVineyard { name = "VegetationVineyard"; value = "VegetationVineyard"; };
            };
            typeName = "STRING";
            defaultValue = """NameVillage""";
        };
        class a3aa_ee_custom_location_delcorpse {
            property = "a3aa_ee_custom_location_delcorpse";
            control = "Checkbox";
            displayName = "Delete player corpses";
            expression = "_this setVariable [""%s"",_value]";
            defaultValue = "false";
            tooltip = "Delete corpse left by a player on disconnect or respawn if that corpse was left in this location. Doesn't affect corpses created via other means (ie. AI corpses or deaths without respawn or disconnect).\n\nIf AI was enabled for the playable slot and player left an alive AI after disconnect, it will also be removed.";
        };
    };
    class EventHandlers : EventHandlers {
        class a3aa_ee_custom_location { init = "if (isServer) then { (_this select 0) call a3aa_ee_modules_fnc_createLoc }"; };
    };
};

class a3aa_ee_briefing : a3aa_ee_shared_module_base {
    scope = 2;
    icon = "\a3\Modules_f\data\portraitHQ_ca.paa";
    displayName = "Briefing (OPORD)";
    class Attributes {
        class a3aa_ee_briefing_briefingfor {
            property = "a3aa_ee_briefing_briefingfor";
            control = "Combo";
            displayName = "Briefing for";
            expression = "_this setVariable [""%s"",_value]";
            class Values {
                class Everyone { name = "Everyone"; value = "everyone"; };
                class Side_BLUFOR { name = "Side - BLUFOR"; value = "side_blufor"; };
                class Side_OPFOR { name = "Side - OPFOR"; value = "side_opfor"; };
                class Side_Indep { name = "Side - Independent"; value = "side_indep"; };
                class Side_Civ { name = "Side - Civilian"; value = "side_civ"; };
                /* synchronizedObjects doesn't work here, we would need to spawn + wait,
                 * but we can't know what to wait for, so this logic can't easily support
                 * briefings for synchronized players */
                //class Synced { name = "Synchronized groups (non-JIP)"; value = "synced"; };
            };
            typeName = "STRING";
            defaultValue = """everyone""";
        };
        class a3aa_ee_briefing_situation {
            property = "a3aa_ee_briefing_situation";
            control = "a3aa_ee_EditBig15";
            displayName = "Situation";
            expression = "_this setVariable [""%s"",_value]";
            defaultValue = """""";
            typeName = "STRING";
        };
        class a3aa_ee_briefing_mission {
            property = "a3aa_ee_briefing_mission";
            control = "a3aa_ee_EditBig15";
            displayName = "Mission";
            expression = "_this setVariable [""%s"",_value]";
            defaultValue = """""";
            typeName = "STRING";
        };
        class a3aa_ee_briefing_execution {
            property = "a3aa_ee_briefing_execution";
            control = "a3aa_ee_EditBig15";
            displayName = "Execution";
            expression = "_this setVariable [""%s"",_value]";
            defaultValue = """""";
            typeName = "STRING";
        };
        class a3aa_ee_briefing_admin_logistics {
            property = "a3aa_ee_briefing_admin_logistics";
            control = "a3aa_ee_EditBig15";
            displayName = "Admin & Logistics";
            expression = "_this setVariable [""%s"",_value]";
            defaultValue = """""";
            typeName = "STRING";
        };
        class a3aa_ee_briefing_command_signal {
            property = "a3aa_ee_briefing_command_signal";
            control = "a3aa_ee_EditBig15";
            displayName = "Command & Signal";
            expression = "_this setVariable [""%s"",_value]";
            defaultValue = """""";
            typeName = "STRING";
        };
    };
    class EventHandlers : EventHandlers {
        class a3aa_ee_briefing { init = "if (isServer) then { (_this select 0) call a3aa_ee_modules_fnc_sendBriefing }"; };
    };
};

class a3aa_ee_teleport_on_jip : a3aa_ee_shared_module_base {
    scope = 2;
    icon = "\a3\Missions_F_Curator\data\img\portraitMPTypeSectorControl_ca.paa";
    displayName = "Teleport on JIP";
    class EventHandlers : EventHandlers {
        class a3aa_ee_teleport_on_jip { init = "if (isServer) then { (_this select 0) call a3aa_ee_modules_fnc_teleportOnJIP }"; };
    };
};

class a3aa_ee_move_respawn : a3aa_ee_shared_module_base {
    scope = 2;
    icon = "\a3\Missions_F_Curator\data\img\portraitMPTypeSectorControl_ca.paa";
    displayName = "Move respawn";
    class Attributes {
        class a3aa_ee_move_respawn_movemarkers {
            property = "a3aa_ee_move_respawn_movemarkers";
            control = "EditArray";
            displayName = "Markers";
            expression = "_this setVariable [""%s"",_value]";
            defaultValue = "[""respawn""]";
            tooltip = "Comma-separated list of marker names to move to this module's 3D position on mission start. The nearest surface below this position will be used on respawn.";
        };
    };
    class EventHandlers : EventHandlers {
        class a3aa_ee_move_respawn { init = "if (isServer) then { (_this select 0) call a3aa_ee_modules_fnc_moveRespawn }"; };
    };
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
        class a3aa_ee_attach_synced { init = "if (isServer) then { (_this select 0) call a3aa_ee_modules_fnc_attachSynced }"; };
    };
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
        class a3aa_ee_kill_on_jip { init = "if (isServer) then { (_this select 0) call a3aa_ee_modules_fnc_killOnJIP }"; };
    };
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
        class a3aa_ee_remove_ace_eh { init = "if (isServer) then { (_this select 0) call a3aa_ee_modules_fnc_removeACEEH }"; };
    };
};
