class CfgPatches {
    class a3aa_ares_extras {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {
            "A3_Modules_F_Curator_Respawn"
        };
    };
};

class CfgFunctions {
    class a3aa_ares_extras {
        class all {
            file = "\a3aa\ares_extras";
            class init { postInit = 1; };
            class curatorMsg;
            class confirm;
            class selectUnits;
            class selectUnitsSelected;
        };
        class task_force {
            file = "\a3aa\ares_extras\task_force";
            class assignTaskForce;
            class unassignTaskForce;
            class informLoopTaskForces { postInit = 1; };
        };
    };
};
