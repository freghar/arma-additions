class CfgPatches {
    class a3aa_ai_cfgbrains {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {};
    };
};

class CfgBrains {
    /*
     * https://community.bistudio.com/wiki/Arma_3:_CfgBrains_Config_Reference
     * https://community.bistudio.com/wiki/Arma_3:_AI_Config_Reference
     */
    class DefaultSoldierBrain {
        class Components {
            class AIBrainAimingErrorComponent {
                /*
                 * defaults cause AI to respond too slowly to "peeking", even
                 * with very high AI skills, disabling this also seems to reduce
                 * the amount of "aiming one way, non-responsive" bugs
                 * - adjust aimingSpeed / spotTime to taste
                 */
                movingInfluence = 0;
                turningInfluence = 0;
                fatigueCoef = 0;
                /*
                 * this is unfortunate, but necessary - otherwise any incoming
                 * fire (even point blank or overhead across building rooftops)
                 * will drastically reduce accuracy, even with ie. 0.05 here
                 * - note that AIBrainSuppressionComponent -> SuppressionRange
                 *   has no effect on this
                 */
                suppressionCoef = 0;
            };
        };
    };
};
