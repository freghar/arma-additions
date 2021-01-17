/* not to self */
if (_this == player) exitWith {};

private ["_act"];

_act = _this addAction [
    "",
    {
        params ["_target", "_caller", "_actionId", "_arguments"];
        [_caller] joinSilent _target;
    },
    nil,
    0,
    true,
    true,
    "",
    "alive _target && {group player != group _target} && {side player == side _target}",
    2
];
_this setUserActionText [
    _act,
    "Join group",
    "<img size='2' color='#00ffff' image='\A3\ui_f\data\map\markers\military\join_CA.paa'/>"
];

_act = _this addAction [
    "",
    {
        params ["_target", "_caller", "_actionId", "_arguments"];
        [_target, {
            private _grp = group _this;
            [_grp, _this] remoteExec ["selectLeader", groupOwner _grp];
        }] remoteExec ["call", 2];
    },
    nil,
    0,
    true,
    true,
    "",
    "alive _target && {group player == group _target} && {player == leader group player}",
    2
];
_this setUserActionText [
    _act,
    "Make group leader",
    "<img size='2' color='#00ffff' image='\A3\ui_f\data\map\markers\military\flag_CA.paa'/>"
];

_act = _this addAction [
    "",
    {
        params ["_target", "_caller", "_actionId", "_arguments"];
        [_caller] joinSilent grpNull;
    },
    nil,
    0,
    true,
    true,
    "",
    "count units group player > 1",
    2
];
_this setUserActionText [
    _act,
    "Leave current group",
    "<img size='2' color='#00ffff' image='\A3\ui_f\data\map\markers\military\pickup_CA.paa'/>"
];
