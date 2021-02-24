/*
 * for use in spawned scripts that may have started later than preInit
 * and which thus might be unable to add their own PreloadFinished
 * before it's too late to add it
 *
 * waiting for PreloadFinished is necessary if you want to do any sleeps
 * on JIP, as they otherwise complete instantly for some ~2.5sec after join,
 * see "Arma 3 JIP bug" on https://community.bistudio.com/wiki/time
 *
 * waitUntil { !isNil "a3aa_preload_finished" };
 */

addMissionEventHandler ["PreloadFinished", {
    removeMissionEventHandler ["PreloadFinished", _thisEventHandler];
    a3aa_preload_finished = true;
}];
