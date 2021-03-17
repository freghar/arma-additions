class CfgPatches {
    class a3aa_ee_shared;
    class a3aa_ee_execute_code {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {"a3aa_ee_shared"};
        addonRootClass = "a3aa_ee_shared";
    };
};

class CfgFunctions {
    class a3aa_ee_execute_code {
        class all {
            file = "\a3aa\ee\execute_code";
            class decomment;
            class exec3DEN;
            class execRuntime;
            class execRuntimeClients;
        };
    };
};

class CfgVehicles {
    class Logic;
    class a3aa_ee_shared_module_base : Logic {
        class EventHandlers;
    };
    class a3aa_ee_execute_code : a3aa_ee_shared_module_base {
        scope = 2;
        icon = "\a3\3DEN\Data\CfgWaypoints\Scripted_ca.paa";
        displayName = "Execute code";
        class Attributes {
            class a3aa_ee_execute_code_enabledexec {
                property = "a3aa_ee_execute_code_enabledexec";
                control = "Checkbox";
                displayName = "Enable";
                expression = "_this setVariable [""%s"",_value]";
                defaultValue = "true";
                tooltip = "Enable this module. Uncheck to disable without having to remove the module completely.";
            };
            class a3aa_ee_execute_code_execonmp {
                property = "a3aa_ee_execute_code_execonmp";
                control = "Combo";
                displayName = "Execute on (MP)";
                expression = "_this setVariable [""%s"",_value]";
                class Values {
                    class All { name = "All"; value = 0; };
                    class Server_Only { name = "Server only"; value = 2; };
                    class Clients_Only { name = "Clients only"; value = -2; };
                };
                typeName = "NUMBER";
                defaultValue = "0";
            };
            class a3aa_ee_execute_code_forjip {
                property = "a3aa_ee_execute_code_forjip";
                control = "Checkbox";
                displayName = "Exec for JIP players";
                expression = "_this setVariable [""%s"",_value]";
                defaultValue = "true";
            };
            class a3aa_ee_execute_code_execenv {
                property = "a3aa_ee_execute_code_execenv";
                control = "Combo";
                displayName = "Environment";
                expression = "_this setVariable [""%s"",_value]";
                class Values {
                    class Unscheduled { name = "Unscheduled"; value = 0; };
                    class Scheduled { name = "Scheduled"; value = 1; };
                };
                typeName = "NUMBER";
                defaultValue = "1";
            };
            class a3aa_ee_execute_code_runoninit {
                property = "a3aa_ee_execute_code_runoninit";
                control = "Checkbox";
                displayName = "Run on init";
                expression = "_this setVariable [""%s"",_value]";
                defaultValue = "true";
                tooltip = "Run once, on mission initialization.";
            };
            class a3aa_ee_execute_code_runonrespawn {
                property = "a3aa_ee_execute_code_runonrespawn";
                control = "Checkbox";
                displayName = "Run on respawn";
                expression = "_this setVariable [""%s"",_value]";
                defaultValue = "false";
                tooltip = "Run on each player respawn.\n\nWorks only on clients and fires only for respawn of client's own player unit, not for any other units.";
            };
            class a3aa_ee_execute_code_keepmodule {
                property = "a3aa_ee_execute_code_keepmodule";
                control = "Checkbox";
                displayName = "Keep module after mission start";
                expression = "_this setVariable [""%s"",_value]";
                defaultValue = "false";
                tooltip = "Keep this module around at all times and pass it as an object argument to the executed code. This allows the use of this module as a reference point (for positions, distances, synchronizedObjects, etc.).";
            };
            class a3aa_ee_execute_code_code {
                property = "a3aa_ee_execute_code_code";
                control = "a3aa_ee_EditCode30";
                displayName = "Code";
                expression = "_this setVariable [""%s"",_value]";
                defaultValue = """""";
                typeName = "STRING";
                /* does only init line -like validation, forbits passed local vars
                * like _this on the compiler level - unusable for ie. respawn code */
                //validate = "expression";
                tooltip = "Code to run. No valid arguments are passed except when the ""Keep module"" checkbox is selected.";
            };
        };
        class EventHandlers : EventHandlers {
            class a3aa_ee_execute_code { init = "if (isServer) then { (_this select 0) call a3aa_ee_execute_code_fnc_execRuntime }"; };
        };
    };
    class a3aa_ee_execute_code_3den : a3aa_ee_shared_module_base {
        scope = 2;
        icon = "\a3\3DEN\Data\CfgWaypoints\Scripted_ca.paa";
        displayName = "Execute code (Eden)";
        class Attributes {
            class a3aa_ee_execute_code_3den_structured_hint {
                property = "a3aa_ee_execute_code_3den_structured_hint";
                control = "StructuredText1";
                description = "Hint: This module will self-delete itself after code execution. See the inhibitor module.";
            };
            class a3aa_ee_execute_code_3den_code {
                property = "a3aa_ee_execute_code_3den_code";
                control = "a3aa_ee_EditCode30";
                displayName = "Code";
                expression = "[_this, _value] call a3aa_ee_execute_code_fnc_exec3DEN";
                defaultValue = """""";
                typeName = "STRING";
                tooltip = "Code to run in the Eden editor whenever this module is pasted, placed from a composition or when you press ""OK"". This module is passed as an argument.";
            };
        };
    };
    class a3aa_ee_execute_code_3den_inhibit : a3aa_ee_shared_module_base {
        scope = 2;
        icon = "\a3\3DEN\Data\CfgWaypoints\Scripted_ca.paa";
        displayName = "Execute code inhibit (Eden)";
        class Attributes {
            class a3aa_ee_execute_code_3den_inhibit_structured_hint {
                property = "a3aa_ee_execute_code_3den_inhibit_structured_hint";
                control = "StructuredText2";
                description = "Hint: When this module is present in Eden, ""Execute Code (Eden)"" does not execute its code and does not delete itself. This module has no other use.";
            };
        };
    };
};
