/*
 * make AI more likely to use indoor spaces
 * - note that this doesn't make them deliberately search through buildings
 *   to find enemies, it's only used for shortest path calculation
 */

class CfgPatches {
    class a3aa_ai_enter_buildings {
        units[] = {};
        weapons[] = {};
        magazines[] = {};
        requiredAddons[] = { "A3_Data_F" };
    };
};

class CfgVehicles {
    class All;
    class Static : All {
        /*
         * how likely is AI to use an indoor space
         */
        coefInside = 1.1;  // default: 2
        /*
         * this seems to be tied to how "hard" the engine searches for a path
         * through inside spaces - larger values tend to "freeze" units more,
         * smaller values result in simpler pathfinding, ie. using large roads
         * instead of tight alleyways, but also break COMBAT covering movement
         * - disable the modification in the end, was causing deadlocks in CQB
         */
        //coefInsideHeur = 1;  // default: 2
        /*
         * how fast the AI unit moves inside, make it the same as outside
         * - larger values result in slower movement
         */
        coefSpeedInside = 1;  // default: 2
    };
};
