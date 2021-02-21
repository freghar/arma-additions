class CfgPatches {
    class a3aa_ee_move_respawn {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {"a3aa_ee_shared"};
    };
};

class CfgFunctions {
    class a3aa_ee_move_respawn {
        class all {
            file = "\a3aa\ee\move_respawn";
            class move;
        };
    };
};

class CfgVehicles {
    class Logic;
    class a3aa_ee_shared_module_base : Logic {
        class EventHandlers;
    };
    class a3aa_ee_move_respawn : a3aa_ee_shared_module_base {
        scope = 2;
        icon = "\a3\Missions_F_Curator\data\img\portraitMPTypeSectorControl_ca.paa";
        displayName = "Move respawn";
        class Attributes {
            class a3aa_ee_move_respawn_movemarkers {
                property = "a3aa_ee_move_respawn_movemarkers";
                control = "EditArray";
                displayName = "Markers";
                expression = "_this setVariable [""%s"",_value]";
                defaultValue = "[""respawn""]";
                tooltip = "Comma-separated list of marker names to move to this module's 3D position on mission start. The nearest surface below this position will be used on respawn.";
            };
        };
        class EventHandlers : EventHandlers {
            class a3aa_ee_move_respawn { init = "if (isServer) then { (_this select 0) call a3aa_ee_move_respawn_fnc_move }"; };
        };
    };
};
