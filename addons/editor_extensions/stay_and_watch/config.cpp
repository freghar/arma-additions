class CfgPatches {
    class a3aa_ee_stay_and_watch {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {"a3aa_ee_shared"};
    };
};

class CfgFunctions {
    class a3aa_ee_stay_and_watch {
        class all {
            file = "\a3aa\ee\stay_and_watch";
            class handle;
        };
    };
};

class Cfg3DEN {
    class Object {
        class AttributeCategories {
            class StateSpecial {
                class Attributes {
                    class a3aa_ee_stay_and_watch_stay {
                        property = "a3aa_ee_stay_and_watch_stay";
                        control = "Checkbox";
                        displayName = "Stay in place (disable PATH)";
                        expression = "[_this, '%s', _value] call a3aa_ee_stay_and_watch_fnc_handle";
                        condition = "objectBrain";
                        defaultValue = "false";
                        tooltip = "Unlike other implementations, this is MP safe and locality transfer safe. Note that if you re-enable PATH via enableAI and do a locality transfer afterwards, the PATH will be disabled again (unless you remoteExec that enableAI).";
                    };
                    class a3aa_ee_stay_and_watch_watch {
                        property = "a3aa_ee_stay_and_watch_watch";
                        control = "Checkbox";
                        displayName = "Watch current direction";
                        expression = "[_this, '%s', _value] call a3aa_ee_stay_and_watch_fnc_handle";
                        condition = "objectBrain";
                        defaultValue = "false";
                        tooltip = "This commands the AI unit to watch a direction it has been rotated to in the editor. Works persistently in MP across locality transfers. Useful for keeping stationary sentries (in combination with disabling PATH) in one group.";
                    };
                };
            };
        };
    };
};
