if (is3DEN) exitWith {};
if (!isClass (configFile >> "CfgPatches" >> "ace_medical")) exitWith {};

private _cond = _this getVariable "a3aa_ee_remove_ace_eh_cond";

(compile _cond) remoteExecCall ["a3aa_ee_remove_ace_eh_fnc_setupClassEH", 0, true];

deleteVehicle _this;
