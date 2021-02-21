if (!hasInterface || !isRemoteExecutedJIP) exitWith {};

waitUntil { !isNull player };

/* don't kill VirtualSpectator_F and other logic units */
if (side player == sideLogic) exitWith {};

player setDamage 1;
