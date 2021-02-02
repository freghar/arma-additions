/*
 * by default, fn_updateUnit does nothing - we have to flag units as eligible
 * for a dynamic skill update
 *
 * this is done here, where we wait for other logic (3den enhanced, skill slider
 * in the editor, or other custom scripts) to adjust the skill - if such logic
 * is detected, avoid dynamic updates
 *
 * also wait until the engine initializes the unit, which starts with 0 skill
 * and receives the 0.5 default only some time after creation
 * - that's why this is 'local' and tells server to register the unit; in rare
 *   cases with a lagged unit creator (zeus), 2 seconds server-side would not
 *   be enough
 */

if (!local _this) exitWith {};

0 = _this spawn {
    /* a lot of scripts tend to sleep 1 */
    sleep 2;
    /* might have been killed/deleted, save work later */
    if (!alive _this) exitWith {};

    /* account for rounding, networked scripts modifying our own unit */
    if (!(_this call a3aa_ai_dynamic_skill_fnc_hasDefaultSkills)) exitWith {};

    if (isServer) then {
        a3aa_ai_dynamic_skill_units pushBack _this;
    } else {
        [_this, {
            a3aa_ai_dynamic_skill_units pushBack _this;
        }] remoteExec ["call", 2];
    };
};
