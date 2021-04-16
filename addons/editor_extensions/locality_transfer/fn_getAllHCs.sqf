/*
 * return owner IDs of all connected and active headless clients
 * - this actually works even before game start, even before all HCs fully
 *   connect to briefing screen
 */

/* unique, one HC slowly takes over all HeadlessClient_F entities */
private _all = (entities "HeadlessClient_F" apply { owner _x }) - [0,2];
_all arrayIntersect _all;
