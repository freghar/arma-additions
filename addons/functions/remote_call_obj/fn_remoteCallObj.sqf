/*
 * this behaves like remoteExec when given an object as the JIP argument,
 *   (str player) remoteExec ["systemChat", 0, player]
 * meaning it keeps the JIP entry only as long as the object is non-null,
 * but allows you to add multiple JIP entries whereas remoteExec itself
 * overrides a previous JIP queue entry when given the same object for
 * unrelated remoteExecs
 * see the big red box on the BI wiki for remoteExec
 *
 * _func can be STRING or CODE or [arg,STRING] or [arg,CODE]
 *
 * _cond is an optional condition for when the JIP entry should be removed,
 * use only AG scripting commands as _this will be REMOTE
 */

params ["_func", "_targets", "_obj", ["_cond", { isNull _this }]];

private _longrand = ((random 100000000000000000) tofixed 0) + ((random 100000000000000000) tofixed 0);
private _unique_id = format ["rnd%1_%2", _longrand, _obj call BIS_fnc_netId];

private _meta = [_func, _obj, _cond, _unique_id];
_meta remoteExecCall ["a3aa_fnc_remoteCallObj_wrapper", _targets, _unique_id];
