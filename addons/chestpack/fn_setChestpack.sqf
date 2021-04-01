/* add chestpack to '_unit', according to getUnitLoadout-formatted
 * '_backinfo' (backpack array), saved by fn_delBackpack */

params ["_unit", "_packinfo"];
_packinfo params ["_packclass"];

private _obj = [_packclass, [0,0,0], 0, false] call BIS_fnc_createSimpleObject;
_obj attachTo [_unit, [0,-0.05,-0.4], "Spine3", true];
_obj setVectorDirAndUp [[0,-1,0], [0,0,1]];

[_unit, true] remoteExec ["forceWalk", _unit];
_unit setVariable ["a3aa_chestpack_pack", [_obj, _packinfo], true];
