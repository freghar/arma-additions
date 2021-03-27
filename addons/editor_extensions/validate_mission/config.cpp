class CfgPatches {
    class a3aa_ee_validate_mission {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {
            "a3aa_ee_shared",
            "cba_xeh"
        };
    };
};

class CfgFunctions {
    class a3aa_ee_validate_mission {
        class all {
            file = "\a3aa\ee\validate_mission";
            class runAllChecks;
            class getEntityInfo;
            class register;
        };
        class checks {
            file = "\a3aa\ee\validate_mission\checks";
            class checkOverload;
            class checkAcreIds;
            class checkOrdering;
        };
    };
};

class ctrlMenuStrip;
class display3DEN {
    class Controls {
        class MenuStrip: ctrlMenuStrip {
            class Items {
                class a3aa_ee {
                    items[] += {
                        "a3aa_ee_validate_mission"
                    };
                };
                class a3aa_ee_validate_mission {
                    text = "Validate mission";
                    picture = "\a3\Modules_F\Data\iconTaskSetState_ca.paa";
                    action = "collect3DENHistory { [] call a3aa_ee_validate_mission_fnc_runAllChecks }";
                };
            };
        };
    };
};

#define QUOTE(x) #x
#define CONCAT3(a,b,c) a##b##c
#define REGISTER(x) \
    class a3aa_ee_validate_mission_##x { \
        init = QUOTE(CONCAT3(a3aa_ee_validate_mission_fnc_,x, call a3aa_ee_validate_mission_fnc_register)); \
    }

class Extended_PreInit_EventHandlers {
    REGISTER(checkOverload);
    REGISTER(checkAcreIds);
    REGISTER(checkOrdering);
};
