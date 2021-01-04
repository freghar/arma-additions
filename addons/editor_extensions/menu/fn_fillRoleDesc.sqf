/*
 * fill in Role Description of all selected units, using their group callsign
 * and unit name
 * - vanilla Arma 3 uses some default groupID in lobby, not the one from Eden
 */

if (!is3DEN) exitWith {};

private "_desc";
{
    /* start with unit displayName */
    _desc = getText (configOf _x >> "displayName");
    if (_desc isEqualTo "") then { _desc = typeOf _x };
    /* prepend group callsign */
    _desc = format ["%1, %2", groupId group _x, _desc];
    /* append "leader" if group leader */
    if (leader _x == _x) then { _desc = format ["%1 (leader)", _desc] };
    /* set description */
    _x set3DENAttribute ["description", _desc];
} forEach get3DENSelected "object";
