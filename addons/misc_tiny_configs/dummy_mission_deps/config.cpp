/*
 * provide old (previous) CfgPatches until missions switch over
 */

#define PATCH(name) \
    class name { \
        units[] = {}; \
        weapons[] = {}; \
        requiredAddons[] = {}; \
    }

class CfgPatches {
    PATCH(a3aa_mtc_rhs_map_flashlights);
    PATCH(a3aa_ee_modules);
};
