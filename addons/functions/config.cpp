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
        /* fast implementation of a "dict" (hash lookup table) */
        class hash {
            file = "\a3aa\functions\hash";
            class hashAppendUnique;
            class hashCntIncrement;
            class hashGet;
            class hashInit;
            class hashKeyExists;
            class hashKeyVals;
            class hashKeys;
            class hashRem;
            class hashSet;
            class hashValues;
        };
        /* mission persistence (boxes, vehicles, terrain) saving/loading */
        class saveload {
            file = "\a3aa\functions\saveload";
            class loadCargo;
            class loadTerrain;
            class loadVehicle;
            class saveCargo;
            class saveTerrain;
            class saveVehicle;
        };
        /* miscellaneous uncategorized */
        class misc {
            file = "\a3aa\functions\misc";
            class classKindOf;
            class player;
        };
    };
};
