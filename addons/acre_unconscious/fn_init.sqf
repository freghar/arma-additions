if (!isClass (configFile >> "CfgPatches" >> "acre_sys_core")) exitWith {};
if (isClass (configFile >> "CfgPatches" >> "ace_medical")) exitWith {};

if (!hasInterface) exitWith {};

/*
 * This is an ugly hack, I know.
 *
 * Proper fix:
 * https://github.com/IDI-Systems/acre2/issues/985
 */
0 = [] spawn {
    waitUntil { !isNil "a3aa_preload_finished" };
    waitUntil { !isNull player };
    waitUntil {
        private _disabled = player getVariable ["acre_sys_core_isDisabled", false];
        private _alive = lifeState player in ["HEALTHY", "INJURED"];
        if (_alive && _disabled) then {
            player setVariable ["acre_sys_core_isDisabled", false, true];
        } else {
            if (!_alive && !_disabled) then {
                player setVariable ["acre_sys_core_isDisabled", true, true];
            };
        };
        sleep 1;
        false;
    };
};
