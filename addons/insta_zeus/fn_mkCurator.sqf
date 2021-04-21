/* create a new Curator instance, with all addons allowed, returning it */

if (!isServer) exitWith {};

/*
 * While the Curator doesn't require any client-side configuration and once
 * assigned, it Just Works for the assigned client, there are some nice
 * features and keybinds people know from BIS configuration of Curator and
 * these need to be set locally on each client that is going to use the
 * Curator.
 *
 * Hence _forclient:
 *   player object or client id to create EHs for, 0 = everybody
 */
params [["_forclient", 0]];

private _lgroup = creategroup [sideLogic, true];
private _logic = _lgroup createUnit ["a3aa_insta_zeus_dumb_curator", [0,0,0], [], 0, "NONE"];

private _addons = ("true" configClasses (configFile >> "CfgPatches")) apply { configName _x };
//activateAddons _addons;  // doesn't seem necessary
removeAllCuratorAddons _logic;
_logic addCuratorAddons _addons;

private _onjip = if (_forclient isEqualTo 0) then { true } else { false };

_logic remoteExec ["a3aa_insta_zeus_fnc_mkCuratorAddEHs", _forclient, _onjip];

_logic;
