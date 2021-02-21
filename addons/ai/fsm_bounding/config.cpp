/*
 * keep a tight group and move faster while in COMBAT
 */

class CfgPatches {
    class a3aa_ai_fsm_bounding {
        units[] = {};
        weapons[] = {};
        magazines[] = {};
        requiredAddons[] = { "A3_Characters_F" };
    };
};

class CfgFSMs {
    class Formation {
        class States {
            class Search_path__Covering {
                class Init {
                    function = "searchPath";
                    thresholds[] = {};
                    /*
                     * first nr: how far (in meters) to move between bounding steps,
                     *   0 will behave like with AUTOCOMBAT disabled
                     * second nr: how far (from where?) to look for cover
                     *   0 will never look for cover (will go prone on the spot)
                     *   smaller values tend to result in tighter grouping
                     */
                    parameters[] = {20, 2};  // default 10, 5
                    /* see also: https://feedback.bistudio.com/T73656 */
                };
            };
        };
    };
};
