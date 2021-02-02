/*
 * run every frame, unscheduled, process one unit
 */

if (!alive _this || !simulationEnabled _this || _this in allPlayers) exitWith {};

/*
 * if skills have been modified by external logic, stop dynamic updates
 * - since we set the skills ourselves, there are no rounding errors
 */
private _previous = _this getVariable "a3aa_ai_dynamic_skill_prevskills";
private _current = _this call a3aa_ai_dynamic_skill_fnc_getSkills;
if (!isNil "_previous" && {!(_previous isEqualTo _current)}) exitWith {
    a3aa_ai_dynamic_skill_units
        deleteAt (a3aa_ai_dynamic_skill_units find _this);
};

private _new = [_this, _current] call a3aa_ai_dynamic_skill_fnc_calcSkills;

/* avoid unnecessary network update */
if (_new isEqualTo _current) exitWith {};

[_this, _new] call a3aa_ai_dynamic_skill_fnc_setSkills;

_this setVariable ["a3aa_ai_dynamic_skill_prevskills", _new];
