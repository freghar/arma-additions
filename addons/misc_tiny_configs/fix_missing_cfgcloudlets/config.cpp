/*
 * fix annoying pop-up errors when some CUP (or similar) buildings are destroyed
 */

class CfgPatches {
    class fix_missing_cfgcloudlets {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {
            "A3_Data_F_ParticleEffects"
        };
    };
};

class CfgCloudlets {
    /* CUP et. al. */
    class HouseDestructionSmoke1;
    class housedestructionsmoke : HouseDestructionSmoke1 {};
    /* fuel stations, Lingor, etc. */
    class FuelFire1;
    class fuelstationexp : FuelFire1 {};
    class ObjectDestructionSmokeFuelS;
    class fuelsmoke1 : ObjectDestructionSmokeFuelS {};
    class ObjectDestructionSmokeFuelS1_2;
    class fuelsmoke2 : ObjectDestructionSmokeFuelS1_2 {};
};
