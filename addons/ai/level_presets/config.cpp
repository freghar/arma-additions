/*
 * enforce 1.0 AI skill scaling
 */

class CfgPatches {
    class a3aa_ai_level_presets {
        units[] = {};
        weapons[] = {};
        magazines[] = {};
        requiredAddons[] = {};
    };
};

class CfgAILevelPresets {
    /* up Regular and Veteran to maximum */
    class AILevelMedium {
        skillAI = 1;
        precisionAI = 1;
    };
    class AILevelHigh {
        skillAI = 1;
        precisionAI = 1;
    };
};
