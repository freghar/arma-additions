/*
 * like CBA's Invisible Targets, but also invisible by AI
 * - useful for adding to AI groups as remote spotters
 */

class CfgPatches {
    class a3aa_mtc_invisible_spotter {
        units[] = {
            "a3aa_mtc_invisible_spotter_b",
            "a3aa_mtc_invisible_spotter_o",
            "a3aa_mtc_invisible_spotter_i"
        };
        weapons[] = {};
        requiredAddons[] = {
            "cba_ai"
        };
    };
};

#define SPOTTER_ATTRS \
    displayName = "Invisible Spotter"; \
    icon = "\a3\3DEN\Data\CfgWaypoints\SeekAndDestroy_ca.paa"; \
    camouflage = 0.0000001; \
    audible = 0.0000001; \
    class EventHandlers : EventHandlers { \
        class a3aa_mtc_invisible_spotter { \
            init = "(_this select 0) setSkill 1"; \
        }; \
    };

class CfgVehicles {
    class B_TargetSoldier;
    class CBA_B_InvisibleTarget : B_TargetSoldier {
        class EventHandlers;
    };
    class a3aa_mtc_invisible_spotter_b : CBA_B_InvisibleTarget {
        SPOTTER_ATTRS
    };

    class O_TargetSoldier;
    class CBA_O_InvisibleTarget : O_TargetSoldier {
        class EventHandlers;
    };
    class a3aa_mtc_invisible_spotter_o : CBA_O_InvisibleTarget {
        SPOTTER_ATTRS
    };

    class I_TargetSoldier;
    class CBA_I_InvisibleTarget : I_TargetSoldier {
        class EventHandlers;
    };
    class a3aa_mtc_invisible_spotter_i : CBA_I_InvisibleTarget {
        SPOTTER_ATTRS
    };
};
