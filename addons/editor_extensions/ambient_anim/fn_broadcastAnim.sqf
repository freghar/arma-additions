params ["_unit_anims", "_maxdelay"];

//sleep 1;
if (didJIP) then {
    /*
     * on JIP, the server broadcasts the current unit animation, but
     * without regard for delay, so we still run the logic below,
     * overriding the anim phase .. after loading ingame
     */
    sleep 10;
} else {
    waitUntil { !isNil "BIS_fnc_init" };
};

{
    _x params ["_unit", "_anim", "_delay"];
    if (_delay > 0) then {
        0 = [_unit, _anim, _delay] spawn {
            params ["_unit", "_anim", "_delay"];
            sleep _delay;
            [_unit, _anim] call a3aa_ee_ambient_anim_fnc_doAnim;
        };
    } else {
        [_unit, _anim] call a3aa_ee_ambient_anim_fnc_doAnim;
    };
} forEach _unit_anims;
