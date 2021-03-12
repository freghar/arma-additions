class CfgPatches {
    class a3aa_ee_acre_channels {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {"a3aa_ee_shared"};
    };
};

class CfgFunctions {
    class a3aa_ee_acre_channels {
        class all {
            file = "\a3aa\ee\acre_channels";
            class setChannels;
            class initClient { postInit = 1; };
        };
    };
};

class Cfg3DEN {
    class Object {
        class AttributeCategories {
            class Control {
                class Attributes {
                    class a3aa_ee_acre_channels_chlist {
                        property = "a3aa_ee_acre_channels_chlist";
                        control = "EditArray";
                        displayName = "ACRE2 Preset Channels";
                        expression = "_this setVariable [""%s"",_value,true]";
                        condition = "objectBrain";
                        defaultValue = "[]";
                        tooltip = "List of channel numbers to be set by default when a player spawns in. First number in the list is for the first (primary) radio (ie. PRC343), second number is for the second (ie. PRC148), etc., based on inventory order. A special value 0 means to leave the default.\n\nExamples:\n2, 2 = 1st and 2nd radios to channel 2, others ignored\n0, 3 = ignore 1st, set 2nd to channel 3, ignore the rest";
                    };
                };
            };
        };
    };
};
