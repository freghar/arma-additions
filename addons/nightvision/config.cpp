/*
 * make NVGs full-screen and ACE-like in visual appearance
 */
class CfgPatches {
    class A3_Weapons_F;
    class a3aa_nightvision {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {
            "A3_Weapons_F",
            "A3_Weapons_F_Exp",
            "cba_events",
            "cba_xeh"
        };
        addonRootClass = "A3_Weapons_F";
    };
};

class CfgFunctions {
    class a3aa_nightvision {
        class all {
            file = "\a3aa\nightvision";
            class init;
            class enableNVGEffects;
        };
    };
};

class Extended_PreInit_EventHandlers {
    class a3aa_nightvision {
        init = "[] call a3aa_nightvision_fnc_init";
    };
};

#define DISPLAY_DISABLE(rscname) \
    class rscname { \
        a3aa_nightvision = "[false] call a3aa_nightvision_fnc_enableNVGEffects"; \
    }
#define DISPLAY_RESTORE(rscname) \
    class rscname { \
        a3aa_nightvision = "[] call a3aa_nightvision_fnc_enableNVGEffects"; \
    }

class Extended_DisplayLoad_EventHandlers {
    DISPLAY_DISABLE(RscDisplayCurator);
    DISPLAY_DISABLE(RscDisplayArsenal);
    /* just in case ace_arsenal is used without ace_nightvision */
    DISPLAY_DISABLE(ace_arsenal_display);
};
class Extended_DisplayUnload_EventHandlers {
    DISPLAY_RESTORE(RscDisplayCurator);
    DISPLAY_RESTORE(RscDisplayArsenal);
    DISPLAY_RESTORE(ace_arsenal_display);
};

class CfgWeapons {
    /*
     * remove black screen border/overlay of NVGs
     *
     * surprisingly, this is fully compatible with ACE Nightvision as they do
     * exactly the same thing, but then apply their own semi-transparent mask
     * on top of it, which they couldn't with a non-transparent black border
     */
    class Binocular;
    class NVGoggles : Binocular {
        modelOptics = "";
    };
    class NVGoggles_INDEP : NVGoggles {
        modelOptics = "";
    };
    class NVGoggles_OPFOR : NVGoggles {
        modelOptics = "";
    };
    class NVGogglesB_blk_F : NVGoggles {
        modelOptics = "";
    };
    class O_NVGoggles_hex_F : NVGoggles {
        modelOptics = "";
    };
};
