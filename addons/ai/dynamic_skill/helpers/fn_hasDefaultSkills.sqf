/*
 * return true if the passed unit has 0.5 skills, account for network-induced
 * rounding errors
 */

private _skills = _this call a3aa_ai_dynamic_skill_fnc_getSkills;
if (_skills findIf { abs (_x - 0.5) > 0.05 } != -1) then {
    false;
} else {
    true;
};
