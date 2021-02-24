if (!hasInterface || !isRemoteExecutedJIP) exitWith {};

/*
 * due to some stupid vanilla logic, the player unit is being teleported
 * on JIP several times at seemingly random points (ie. [0,0,0] or half-
 * way between our teleport destination and the original spawn point
 *
 * even if we keep teleporting for several seconds to the destination,
 * the player might be teleported back once our timer ends
 * - this suggests that vanilla keeps teleporting the unit back to start
 *   until it detects player on the starting position
 *
 * so instead of constantly teleporting the player to dest, give vanilla
 * logic a chance to register the starting position before we teleport
 * the player once (no need to re-try)
 */

0 = [] spawn {
    waitUntil { !isNil "a3aa_preload_finished" };
    sleep 1;

    waitUntil { !isNil "a3aa_ee_teleport_on_jip_dmg" };

    /* add 1m to Z, just in case it's inside a road, etc. */
    waitUntil { !isNil "a3aa_ee_teleport_on_jip_pos" };
    private _pos = +a3aa_ee_teleport_on_jip_pos;
    _pos set [2, (_pos select 2) + 1];
    moveOut player;
    player setVelocity [0,0,0];
    player setPosASL _pos;

    sleep 1;
    player allowDamage a3aa_ee_teleport_on_jip_dmg;
    a3aa_ee_teleport_on_jip_dmg = nil;
};

waitUntil { !isNull player };
a3aa_ee_teleport_on_jip_dmg = isDamageAllowed player;
player allowDamage false;
