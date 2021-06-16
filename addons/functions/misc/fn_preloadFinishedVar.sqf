/*
 * for use in spawned scripts that may have started later than preInit
 * and which thus might be unable to add their own PreloadFinished
 * before it's too late to add it
 *
 * waiting for PreloadFinished is necessary if you want to do any sleeps
 * on JIP, as they otherwise complete instantly for some ~2.5sec after join,
 * see "Arma 3 JIP bug" on https://community.bistudio.com/wiki/time
 *
 * same idea with waiting for CBA settings to be initialized - you'd want
 * to hook up your code directly to the CBA Event, but can't (easily) if
 * you run from ie. a module, or a keypress, you'd have to do 2 levels of
 * indirection and waitUntil in already scheduled code is much simpler
 *
 * waitUntil { !isNil "a3aa_preload_finished" };
 *
 * waitUntil { !isNil "a3aa_settings_initialized" };
 */

addMissionEventHandler ["PreloadFinished", {
    removeMissionEventHandler ["PreloadFinished", _thisEventHandler];
    a3aa_preload_finished = true;
}];

["CBA_settingsInitialized", {
    a3aa_settings_initialized = true;
}] call CBA_fnc_addEventHandler;
