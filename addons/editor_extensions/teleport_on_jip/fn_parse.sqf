if (is3DEN) exitWith {};

/* global publicVariable, can be overwritten by external logic */
a3aa_ee_teleport_on_jip_pos = getPosASL _this;
publicVariable "a3aa_ee_teleport_on_jip_pos";

remoteExec ["a3aa_ee_teleport_on_jip_fnc_teleport", 0, true];

deleteVehicle _this;
