/*
 * misc changes to default Arma difficulties
 */

class CfgPatches {
    class a3aa_mtc_difficulties {
        units[] = {};
        weapons[] = {};
        magazines[] = {};
        requiredAddons[] = {
            "A3_Data_F"
        };
    };
};

/*
 * set Veteran to some reasonable realism-minded values that I play with
 * set Regular to be similar, but less hardcore and more useful in SP
 * and for testing/screenshots, as Regular is the default
 */
class CfgDifficultyPresets {
    class Veteran {
        class Options {
            reducedDamage = 0;
            groupIndicators = 1;
            friendlyTags = 0;
            enemyTags = 0;
            detectedMines = 0;
            commands = 0;
            waypoints = 0;
            tacticalPing = 1;
            weaponInfo = 2;
            stanceIndicator = 2;
            staminaBar = 1;
            weaponCrosshair = 0;
            visionAid = 0;
            squadRadar = 0;
            thirdPersonView = 0;
            cameraShake = 1;
            scoreTable = 0;
            deathMessages = 0;
            vonID = 1;
            mapContent = 0;
            autoReport = 0;
            multipleSaves = 1;
        };
    };
    class Regular {
        class Options {
            reducedDamage = 0;
            groupIndicators = 1;
            friendlyTags = 0;
            enemyTags = 0;
            detectedMines = 1;
            commands = 1;
            waypoints = 2;
            tacticalPing = 1;
            weaponInfo = 2;
            stanceIndicator = 2;
            staminaBar = 1;
            weaponCrosshair = 0;
            visionAid = 0;
            squadRadar = 0;
            thirdPersonView = 1;
            cameraShake = 1;
            scoreTable = 1;
            deathMessages = 0;
            vonID = 1;
            mapContent = 0;
            autoReport = 0;
            multipleSaves = 1;
        };
    };
};
