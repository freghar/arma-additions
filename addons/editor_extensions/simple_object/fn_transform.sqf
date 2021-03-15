params ["_unit", "_value"];

private _preconfigured = 
    getNumber (configOf _unit >> "SimpleObject" >> "eden") == 1;

/*
 * if in 3den *and* editing a preconfigured object, attr config default already
 * pre-fills our checkbox value with whatever values is in objectIsSimple,
 * so this code runs only if the user explicitly changed our checkbox,
 * in which case make the objectIsSimple checkbox value mirror ours
 */
if (is3DEN) exitWith {
    if (_preconfigured) then {
        _unit set3DENAttribute ["objectIsSimple", _value];
    };
};

/*
 * if not handled by the engine, do the transformation here
 */
if (_preconfigured) exitWith {};

// TODO: re-create without multiple setPos and other overhead
if (_value) then {
    [_unit] call BIS_fnc_replaceWithSimpleObject;
};
