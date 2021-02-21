if (is3DEN) exitWith {};
private _header = _this getVariable "a3aa_ee_insta_osd_header";
private _tojip = _this getVariable "a3aa_ee_insta_osd_tojip";

_header remoteExecCall ["a3aa_ee_insta_osd_fnc_moduleOSDClients", 0, _tojip];

deleteVehicle _this;
