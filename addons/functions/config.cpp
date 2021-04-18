class CfgPatches {
    class a3aa_functions {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {};
    };
};

class CfgFunctions {
    class a3aa {
        class cargo {
            file = "\a3aa\functions\cargo";
            class boxGuard;
        };
        /* simple wrappers for a circular buffer */
        class cbuff {
            file = "\a3aa\functions\cbuff";
            class cbuffInit;
            class cbuffGet;
            class cbuffSet;
        };
        /* remoteExec with support for multiple JIP entries for object/group */
        class remote_call_obj {
            file = "\a3aa\functions\remote_call_obj";
            class remoteCallObj;
            class remoteCallObj_wrapper;
        };
        /* miscellaneous uncategorized */
        class misc {
            file = "\a3aa\functions\misc";
            class classKindOf;
            class preloadFinishedVar { preInit = 1; };
            class balancePerFrame;
            class balancePerFrameCondition;
            class isGuerrilla;
        };
    };
};
