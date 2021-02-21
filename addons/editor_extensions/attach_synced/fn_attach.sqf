if (is3DEN) exitWith {};

0 = _this spawn {
    /* synchronizedObjects can return nil, [] or a valid list of objects
     * depending on where it is run - wait for the first two even though
     * they rarely/never occur in a scheduled script
     */
    waitUntil {
        !isNil { synchronizedObjects _this } &&
            !(synchronizedObjects _this isEqualTo []);
    };

    private _synced = synchronizedObjects _this;
    if (count _synced < 2) exitWith {};  /* need at least target + one other */

    private _target = _synced select 0;
    _synced deleteAt 0;

    {
        [_x, _target] call BIS_fnc_attachToRelative;
    } forEach _synced;

    deleteVehicle _this;
};
