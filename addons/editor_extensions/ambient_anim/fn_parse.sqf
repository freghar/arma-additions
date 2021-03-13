if (is3DEN) exitWith {};

/* if no combat-watching loop is running, start one */
private _exitcombat = _this getVariable "a3aa_ee_ambient_anim_exitcombat";
if (isNil "a3aa_ee_ambient_anim_combatwatch" && _exitcombat) then {
    /* originally synced and "activated" soldiers (not in anim anymore) */
    a3aa_ee_ambient_anim_combatwatch = [[],[]];
    [
        {
            a3aa_ee_ambient_anim_combatwatch params ["_synced", "_active"];
            /* remove already "activated" soldiers from watched ones */
            private _remain = _synced - _active;
            // TODO after v2.03: if _remain is empty, remove _thisEventHandler
            a3aa_ee_ambient_anim_combatwatch = [_remain, []];
            _remain;
        },
        {
            if (
                /* dead or deleted */
                !alive _this ||
                /* entered combat state */
                behaviour _this in ["STEALTH", "COMBAT", "ERROR"] ||
                /* injured */
                { count (((getAllHitPointsDamage _this) select 2) - [0]) > 0 }
            ) then {
                a3aa_ee_ambient_anim_combatwatch params ["_synced", "_active"];
                _active pushBackUnique _this;  /* because objNull */
                _this call a3aa_ee_ambient_anim_fnc_cancelAnim;


            };
        },
        2
    ] call a3aa_fnc_balancePerFrame;
};

0 = _this spawn {
    private _animlist = _this getVariable "a3aa_ee_ambient_anim_animlist";
    private _maxdelay = _this getVariable "a3aa_ee_ambient_anim_maxdelay";
    private _exitcombat = _this getVariable "a3aa_ee_ambient_anim_exitcombat";
    private _exitanim = _this getVariable "a3aa_ee_ambient_anim_exitanim";

    private _parsed_list = _animlist splitString ",. """;
    if (_parsed_list isEqualTo []) exitWith {};

    waitUntil { !isNil "BIS_fnc_init" };

    private _synced_soldiers = (synchronizedObjects _this) select {
        _x isKindOf "CAManBase";
    };
    if (_synced_soldiers isEqualTo []) exitWith {};

    if (_exitcombat) then {
        a3aa_ee_ambient_anim_combatwatch params ["_synced", "_active"];
        _synced append _synced_soldiers;
    };

    {
        [
            _x,
            selectRandom _parsed_list,
            random _maxdelay,
            _exitanim
        ] call a3aa_ee_ambient_anim_fnc_doAnim;
    } forEach _synced_soldiers;

    deleteVehicle _this;
};
