/*
 * note: apply to already initialized units retroactively (last argument: true)
 * as the init EH of our module might be mid-way in object initialization
 */

#define HOOK_EH(target) \
    [#target, "InitPost", { \
        (_this select 0) spawn a3aa_ee_basic_vehicle_cargo_fnc_setCargo; \
    }, true, [], true] call CBA_fnc_addClassEventHandler;

HOOK_EH(Car);
HOOK_EH(Tank);
HOOK_EH(Helicopter);
HOOK_EH(Plane);
HOOK_EH(Ship);

deleteVehicle _this;
