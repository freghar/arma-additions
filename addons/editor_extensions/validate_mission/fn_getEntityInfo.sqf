private ["_info"];

switch true do {
    /* object - unit */
    case (_this in (all3DENEntities select 0)): {
        _info = format ["class:'%1'", typeOf _this];
        private _roledesc = _this get3DENAttribute "description" select 0;
        if (_roledesc != "") then {
            _info = format ["%1 desc:'%2'", _info, _roledesc];
        };
        private _groupid = groupId group _this;
        if (_groupid != "") then {
            _info = format ["%1 group:'%2'", _info, _groupid];
        };
        _info = format ["%1 pos:'%2'", _info, position _this];
    };
    /* group */
    case (_this in (all3DENEntities select 1)): {
        _info = format [
            "group:'%1' pos:'%2'", groupId _this, position leader _this
        ];
    };
    /* system - module */
    case (_this in (all3DENEntities select 3)): {
        _info = format ["class:'%1' pos:'%2'", typeOf _this, position _this];
    };
    /* markers */
    case (_this in (all3DENEntities select 5)): {
        _info = format ["marker:'%1'", _this];
    };
    /* sides */
    case (_this isEqualType west): {
        _info = format ["side:'%1'", _this];
    };
    /* all other */
    default {
        _info = format ["unknown:'%1'", _this];
    };
};

_info;
