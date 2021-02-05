class CfgPatches {
    class a3aa_ee_modules {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {"a3aa_ee_shared"};
    };
};

class CfgFunctions {
    class a3aa_ee_modules {
        class all {
            file = "\a3aa\ee\modules";
            class createLoc;
            class sendBriefing;
            class teleportOnJIP;
            class moveRespawn;
            class attachSynced;
            class killOnJIP;
            class removeACEEH;
        };
    };
};

class CfgVehicles {
#include "modules.h"
};
