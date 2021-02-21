if (is3DEN) exitWith {};
private _area = _this getVariable "objectArea";
private _locname = _this getVariable "a3aa_ee_custom_location_locname";
private _loctype = _this getVariable "a3aa_ee_custom_location_loctype";
private _delcorpse = _this getVariable "a3aa_ee_custom_location_delcorpse";

/*
 * JIP safety;
 * completely decouple details from the logic object as - by the time
 * client gets to parsing the details - the object might have been already
 * deleteVehicle'd by the server
 */
[position _this, _area, _locname, _loctype, vehicleVarName _this, _delcorpse]
    remoteExecCall ["a3aa_ee_custom_location_fnc_createLoc", 0, true];

deleteVehicle _this;
