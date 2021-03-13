/*
 * start animating a soldier
 *
 * remoteExec everywhere since it can take a long while for switchMove to sync
 * from the server - it'll happen eventually, but play at least something until
 * then
 *
 * JIP should be synchronized automatically from the server
 */

0 = _this spawn {
    params ["_unit", "_anim", "_delay", "_exitanim"];
    _unit setVariable ["a3aa_ee_ambient_anim_exitanim", _exitanim];
    sleep _delay;
    [[_unit, _anim], {
        params ["_unit", "_anim"];
        _unit disableAI "ANIM";
        _unit switchMove _anim;
    }] remoteExec ["call"];
};
