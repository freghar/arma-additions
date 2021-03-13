/*
 * cancel a running animation on a soldier
 *
 * since switchMove seems to be synced only after the current animation ends
 * and since we'd rather have immediate change here, remoteExec it to all
 */

private _exit = _this getVariable ["a3aa_ee_ambient_anim_exitanim", ""];
[[_this, _exit], {
    params ["_unit", "_exit"];
    _unit enableAI "ANIM";
    _unit switchMove _exit;
}] remoteExec ["call"];
