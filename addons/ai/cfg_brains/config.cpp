/*
 * tune CfgBrains to make AI respond more to suppression,
 * throw countermeasures (smokes), etc.
 */

class CfgPatches {
    class a3aa_ai_cfg_brains {
        units[] = {};
        weapons[] = {};
        magazines[] = {};
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
            class AIBrainSuppressionComponent {
                /* from 10s for courage=1 to 60s for courage=0 */
                bestDecreaseTime = 10;
                worstDecreaseTime = 60;
                /* lots of bullets to suppress, but one grenade is enough */
                CauseBulletCloseWeight = 0.05;
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
            class AIBrainAimingErrorComponent {
                /* make suppression contribute to error a little bit more */
                suppressionCoef = 0.8;  // default 0.5 is surprisingly close
            };
        };
    };
};
