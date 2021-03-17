class CfgPatches {
    class A3_Air_F_Beta;
    class a3aa_static_line {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {
            "A3_Air_F_Beta",          // NonSteerable_Parachute_F
            "A3_Weapons_F_Ammoboxes"  // B_Parachute
        };
        addonRootClass = "A3_Air_F_Beta";
    };
};

class CfgVehicles {
    class NonSteerable_Parachute_F;
    class a3aa_static_line_straightdown_chute : NonSteerable_Parachute_F {
        airInfluence = 0.1;
    };
    class B_Parachute;
    class a3aa_static_line_straightdown_chute_item : B_Parachute {
        displayName = "Straight-Fall Non-Steerable Chute";
        parachuteClass = "a3aa_static_line_straightdown_chute";
    };
};

class CfgFunctions {
    class a3aa_static_line {
        class all {
            file = "\a3aa\static_line";
            class getPassengers;
            class getPassengerGroups;
            class calcJumpDelay;
            class ejectWithChute;
            class ejectUnits;
            class vehicleChat;
        };
        class action {
            file = "\a3aa\static_line\action";
            class addAction { postInit = 1; };
            class addVanillaAction;
            class canInitiateJump;
            class createACEAction;
        };
    };
};
