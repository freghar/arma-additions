if (is3DEN) exitWith {};

/* run scheduled because synchronizedObjects needs extra time */
0 = _this spawn {

private _animlist = _this getVariable "a3aa_ee_ambient_anim_animlist";
private _maxdelay = _this getVariable "a3aa_ee_ambient_anim_maxdelay";
private _exitcombat = _this getVariable "a3aa_ee_ambient_anim_exitcombat";
private _exitanim = _this getVariable "a3aa_ee_ambient_anim_exitanim";

private _parsed_list = _animlist splitString ",. """;
if (_parsed_list isEqualTo []) exitWith {};

waitUntil {
    !isNil { synchronizedObjects _this } &&
        !(synchronizedObjects _this isEqualTo []);
};
private _synced_soldiers = (synchronizedObjects _this) select {
    _x isKindOf "CAManBase";
};
if (_synced_soldiers isEqualTo []) exitWith {};

/* randomize once, on the server */
private _unit_anims = _synced_soldiers apply {
    [_x, selectRandom _parsed_list, random _maxdelay];
};

/* flag the units as active (for later combat/etc. check) */
{
    _x setVariable ["a3aa_ee_ambient_anim_active", true, true];
} forEach _synced_soldiers;

/* watch (only on the server) for combat state changes */
0 = [_synced_soldiers, _exitcombat, _exitanim] spawn {
    params ["_units", "_exitcombat", "_exitanim"];
    private _discard = [];
    sleep 3;
    waitUntil {
        /* remove combat/dead/deleted/etc. units */
        _units = _units - [objNull] - _discard;
        _discard = [];

        /* check all units every ~2 seconds, spread out */
        private _cnt = count _units;
        if (_cnt > 0) then {
            private _slp = 2 / _cnt;
            {
                if (
                    /* dead or deleted */
                    !alive _x ||
                    /* entered combat state */
                    { _exitcombat && behaviour _x in ["STEALTH", "COMBAT"] } ||
                    /* injured */
                    count (((getAllHitPointsDamage _x) select 2) - [0]) > 0 ||
                    /* made inactive by scripting */
                    !(_x getVariable ["a3aa_ee_ambient_anim_active", false])
                ) then {
                    _x setVariable ["a3aa_ee_ambient_anim_active", nil, true];
                    if (alive _x) then {
                        [[_x, _exitanim], {
                            params ["_unit", "_exit"];
                            _unit enableAI "ANIM";
                            _unit switchMove _exit;
                        }] remoteExec ["call"];
                    };
                    _discard pushBack _x;
                };
                sleep _slp;
            } forEach _units;
            false;
        } else {
            true;
        };
    };
};

/* tell clients to play the animations */
[_unit_anims, _maxdelay]
    remoteExec ["a3aa_ee_ambient_anim_fnc_broadcastAnim", 0, true];

deleteVehicle _this;

};
