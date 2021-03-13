class CfgPatches {
    class a3aa_ee_ambient_anim {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {"a3aa_ee_shared"};
    };
};

class CfgFunctions {
    class a3aa_ee_ambient_anim {
        class all {
            file = "\a3aa\ee\ambient_anim";
            class parse;
            class doAnim;
            class cancelAnim;
        };
    };
};

class CfgVehicles {
    class Logic;
    class a3aa_ee_shared_module_base : Logic {
        class EventHandlers;
    };
    class a3aa_ee_ambient_anim : a3aa_ee_shared_module_base {
        scope = 2;
        icon = "A3\Modules_F_Tacops\Data\CivilianPresenceUnit\icon32_ca.paa";
        displayName = "Ambient animation";
        class Attributes {
            class a3aa_ee_ambient_anim_structured_hint {
                property = "a3aa_ee_ambient_anim_structured_hint";
                control = "StructuredText1";
                description = "Hint: Synchronize soldier units to this module.";
            };
            class a3aa_ee_ambient_anim_animlist {
                property = "a3aa_ee_ambient_anim_animlist";
                control = "Edit";
                displayName = "Anim";
                expression = "_this setVariable [""%s"",_value]";
                typeName = "STRING";
                defaultValue = """""";
                tooltip = "Animation classname. If multiple (comma-separated) are specified, a random one is chosen and played.";
            };
            class a3aa_ee_ambient_anim_maxdelay {
                property = "a3aa_ee_ambient_anim_maxdelay";
                control = "EditShort";
                displayName = "Random delay";
                expression = "_this setVariable [""%s"",_value]";
                typeName = "NUMBER";
                defaultValue = "0";
                tooltip = "Wait up to the specified amount of seconds before applying the animation. Useful when multiple adjacent units share the same animation and you want to avoid their jarring frame-perfect sync with each other.";
            };
            class a3aa_ee_ambient_anim_exitcombat {
                property = "a3aa_ee_ambient_anim_exitcombat";
                control = "Checkbox";
                displayName = "Combat cancels animation";
                expression = "_this setVariable [""%s"",_value]";
                defaultValue = "true";
                tooltip = "When the unit's group enters COMBAT state, exit with the Exit animation.";
            };
            class a3aa_ee_ambient_anim_exitanim {
                property = "a3aa_ee_ambient_anim_exitanim";
                control = "Combo";
                displayName = "Exit animation";
                expression = "_this setVariable [""%s"",_value]";
                class Values {
                    class Standing { name = "Switch to standing"; value = "amovpercmstpsraswrfldnon"; };
                    class Crouching { name = "Switch to crouching"; value = "amovpknlmstpsraswrfldnon"; };
                    class Prone { name = "Switch to prone"; value = "amovppnemstpsraswrfldnon"; };
                };
                typeName = "STRING";
                defaultValue = "0";
                tooltip = "What anim to switch to when cancelling the animation(s) specified above.\n\nThe switching transition should be as close to the ambient animation pose as possible (ie. squatting animation should switch to crouching).";
            };
        };
        class EventHandlers : EventHandlers {
            class a3aa_ee_ambient_anim { init = "if (isServer) then { (_this select 0) call a3aa_ee_ambient_anim_fnc_parse }"; };
        };
    };
};
