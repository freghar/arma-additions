0 = _this spawn {
    params ["_header"];
    waitUntil { !isNil "a3aa_preload_finished" };
    sleep 1;

    if (_header != "") then {
        _header call a3aa_ee_insta_osd_fnc_instaOSD;
    } else {
        [] call a3aa_ee_insta_osd_fnc_instaOSD;
    };
};
