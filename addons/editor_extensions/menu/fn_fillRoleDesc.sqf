/*
 * fill in Role Description of all selected units, using their group callsign
 * and unit name
 */

if (!is3DEN) exitWith {};

private "_desc";
{
    _desc = getText (configOf _x >> "displayName");
    if (_desc isEqualTo "") then { _desc = typeOf _x };
    if (leader _x == _x) then {
        _desc = format ["%1 (leader)", _desc];
    };
    _desc = format ["%1@%2", _desc, groupId group _x];
    _x set3DENAttribute ["description", _desc];
} forEach get3DENSelected "object";
