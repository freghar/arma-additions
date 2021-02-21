class CfgPatches {
    class a3aa_ee_custom_location {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {"a3aa_ee_shared"};
    };
};

class CfgFunctions {
    class a3aa_ee_custom_location {
        class all {
            file = "\a3aa\ee\custom_location";
            class parse;
            class createLoc;
        };
    };
};

class CfgVehicles {
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
            class a3aa_ee_custom_location { init = "if (isServer) then { (_this select 0) call a3aa_ee_custom_location_fnc_parse }"; };
        };
    };
};
