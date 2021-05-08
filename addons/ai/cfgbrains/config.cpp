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
                 * - AIBrainSuppressionComponent -> SuppressionRange
                 *   seems to have no effect whatsoever
                 * - AIBrainSuppressionComponent -> CauseBulletCloseWeight
                 *   is also broken (even with 0, bullets passing by still
                 *   count towards suppression)
                 */
                suppressionCoef = 0;
            };
            class AIBrainSuppressionComponent {
                /* from 10s for courage=1 to 60s for courage=0 */
                bestDecreaseTime = 10;
                worstDecreaseTime = 60;
                /* one grenade explosion = full suppression */
                CauseExplosionWeight = 4;
            };
            class AIBrainCountermeasuresComponent {
                /* min time between smokes? */
                useSmokeGrenadeDelay = 10;
                /* smokes thrown by non-leader group members? */
                nonLeaderSmokeProbability = 0.5;
                /* getSuppression > 0.9 for 8 seconds */
                suppressionThreshold = 0.9;
                suppressionTimerMax = 8;
            };
        };
    };
};
