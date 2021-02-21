params ["_for", "_contents"];

if (isDedicated) exitWith {};  /* player always null */
waitUntil { !isNull player };

private _me = switch (_for) do {
    case "everyone": { true };
    case "side_blufor": { side player == west };
    case "side_opfor": { side player == east };
    case "side_indep": { side player == resistance };
    case "side_civ": { side player == civilian };
    //case "synced": { group player in (_synced apply {group _x}) };
};
if (!_me) exitWith {};

reverse _contents;
{
    _x params ["_head", "_body"];
    /* replace newlines with "<br/>" */
    while {true} do {
        private _pos = _body find toString [10];
        if (_pos == -1) exitWith {};
        private _newbody = _body select [0, _pos];
        _body = _newbody + "<br/>" + (_body select [_pos+1]);
    };
    player createDiaryRecord ["Diary", [_head, _body]];
} forEach _contents;
