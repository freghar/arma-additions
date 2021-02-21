if (isClass (configFile >> "CfgVoice" >> "ACE_NoVoice")) exitWith {};
if (!hasInterface) exitWith {};

0 = [] spawn {
    waitUntil { !isNull player };
    /* setSpeaker is unfortunately EL */
    [
        [player, {
            _this setSpeaker "NoVoice";
            _this addEventHandler ["Respawn", {
                params ["_unit", "_corpse"];
                _unit setSpeaker "NoVoice";
            }];
        }],
        0,
        player,
        { !alive _this }
    ] call a3aa_fnc_remoteCallObj;
};
