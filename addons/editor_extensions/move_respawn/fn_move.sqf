if (is3DEN) exitWith {};

private _markers = _this getVariable "a3aa_ee_move_respawn_movemarkers";

/* put Z 0.1m higher, to account for terrain bugs
 * - this sets only search distance downwards, not an actual position */
private _pos = getPosATL _this;
_pos params ["_x", "_y", "_z"];
_z = _z + 0.1;
_pos = [_x, _y, _z];

0 = [_pos, _markers] spawn {
    params ["_pos", "_markers"];

    /* wait until all markers are initialized */
    waitUntil { time > 0 };
    { _x setMarkerPos _pos } forEach _markers;
};

deleteVehicle _this;
