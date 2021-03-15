class CfgPatches {
    class a3aa_ee_simple_object {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {"a3aa_ee_shared"};
    };
};

class CfgFunctions {
    class a3aa_ee_simple_object {
        class all {
            file = "\a3aa\ee\simple_object";
            class transform;
        };
    };
};

class Cfg3DEN {
    class Object {
        class AttributeCategories {
            class StateSpecial {
                class Attributes {
                    class a3aa_ee_simple_object {
                        property = "a3aa_ee_simple_object";
                        control = "Checkbox";
                        displayName = "Simple Object (universal)";
                        expression = "[_this, _value] call a3aa_ee_simple_object_fnc_transform";
                        condition = "1";
                        /*
                         * if this object has preconfigured SimpleObject data,
                         * always return the state of the objectIsSimple attr
                         * (vanilla Simple Object checkbox), else false (default
                         * for get3DENAttribute if objectIsSimple is passed)
                         */
                        defaultValue = "_this get3DENAttribute 'objectIsSimple' select 0";
                        tooltip = "Turns this object into a SimpleObject. If this object supports engine-native SimpleObject functionality, this merely ticks the vanilla ""Simple Object"" checkbox. If it does not, it re-creates the object on the server upon mission start.";
                    };
                };
            };
        };
    };
};
