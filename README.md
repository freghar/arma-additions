The arma-additions repository
=============================

Here be various small tweaks, additions or fixes of various mods that are
commonly used in "MilSim" or "Serious" Arma 3 gameplay communities.

These are maintained mainly by me (Freghar) and as such are pretty specific
to me, but feel free to browse and cherry-pick what you like or just get
inspired by some algorithms.

Versions
--------

1. Full (CBA + ACE3 + RHSAFRF + RHSUSAF required) - [steam link](https://steamcommunity.com/sharedfiles/filedetails/?id=1470700937)
1. RHS only (CBA + RHSAFRF + RHSUSAF required) - [steam link](https://steamcommunity.com/sharedfiles/filedetails/?id=2140875197)
1. Vanilla edition (only CBA required) - [steam link](https://steamcommunity.com/sharedfiles/filedetails/?id=1470811778)

Most of the code is version-agnostic, so you can run the Vanilla edition with
ACE and most of the features will automatically switch to ACE logic, but there
are several tweaks that need to use the A3 addon dependency to properly override
Configs modified by ACE/RHS, hence the multiple versions.

See further below for ACE compatibility notes.

To build:
1. Full - just use master
1. RHS only - merge in the `noace` branch
1. Vanilla edition - merge in both `norhs` and `noace`

Mods used / modified
--------------------

Aside from the mandatory dependencies (see Versions above), these additions make
use of and configure (but not depend on):

* ACEX - [github](https://github.com/acemod/ACEX/) or [steam](https://steamcommunity.com/workshop/filedetails/?id=708250744)
* Zeus Enhanced (ZEN) - [github](https://github.com/zen-mod/ZEN/) or [steam](https://steamcommunity.com/sharedfiles/filedetails/?id=1779063631)
* ACRE2 - [github](https://github.com/IDI-Systems/acre2) or [steam](https://steamcommunity.com/sharedfiles/filedetails/?id=751965892)

Features
--------

* **acre_unconscious** - prevent (vanilla) unconscious players from talking over ACRE2 direct/radio
* **ai** - dynamic AI skill setting based on combat mode, vehicles, etc., and related AI configs
  * **cfg_ai_skill** - CfgAISkill tuning to reference an absolute 0-1 scale
  * **crew_in_immobile** - makes AI crew stay inside a vehicle with destroyed wheels and get out only if explosion is imminent
  * **dynamic_skill** - the dynamic AI skill logic itself
  * **enter_buildings** - adjustment of indoor preferences, making AI more likely go through buildings to their WP destinations
  * **level_presets** - CfgAILevelPresets tuning to make Regular/Veteran difficulties use 1.0 AI skill scaling
* **ares_extras** - additions to (former) Ares, then Achilles, now ZEN
  * **Forget enemies** - incredibly useful if AI suddenly spots sneaky players and you don't want to break the immersion
  * **Reveal enemies** - useful to make AI start shooting on a target which should be obvious
  * **Watch** - makes AI turn to watch a direction (ie. tank turret)
  * **No unload in combat** - stops truck passengers from jumping out when shot upon
  * **Flee** - forcibly make AI run somewhere
  * **Suppress (bis)** - calls doSuppressiveFire scripting cmd, makes tank shoot cannot at heli, etc.
  * **Assign Task Force** - allows sharing reported contacts between AI groups, so they shoot more
  * **Force WP Setting** - if you set yellow face (AWARE) on a waypoint, this forces it even if AI gets shot at
  * **No Talking** - because elite infiltrators shouldn't shout when they spot you
  * **Locality - Get/Set** - for moving units between server/client/HC
  * **Promote to Zeus (lightweight)** - creates a new Curator and assigns it to the player, but without the extra sauce ZEN adds
  * **Terrain Objects Hide/Show** - pretty obvious, doesn't work persistenly though
  * **Set new player unit** - basically what Achilles used to do on Alt+doubleclick, but for another client, not Zeus
  * **End Mission - Won/Lost** - with an extra export call to CNTO's mission recording addon
  * **Move respawn** - set new position for the respawn_\* map marker placed in editor
  * **Move JIP teleport point** - same, but for the JIP teleport editor module
  * **Delete units (really)** - very handy if pressing the Delete key throws an error msg because Arma
* **chestpack** - it's a backpack for your belly! .. for when you need something more immediate on your back, like a parachute
* **disable_channels** - disable unused chat channels, CBA configurable
* **door_keybind** - opening/closing doors via a CBA keybind
* **editor_extensions** - various in-editor enhancements
  * **acre_channels** - pre-set channels for (multiple) ACRE2 radios a unit might have, complete with in-game Journal entries
  * **ambient_anim** - a module to make linked units animate, MP-synced, optionally aborts when unit enters combat
  * **arsenal_respawn** - save starting Arsenal loadout, restore it on respawn
  * **attach_synced** - visually position an ammo box on a quadbike's back and sync both to this module, magic happens
  * **basic_vehicle_cargo** - replace default vehicle contents (NLAW, etc.) with something else
    * (can be overriden on a per-vehicle basis via checkbox in editor)
  * **briefing** - populates in-game Journal with OPORD-style entries, uses Arma's Structured Text formatting (see wiki)
  * **custom_location** - create a Location like a new town/village/castle/bus/etc., works with insta_osd and is visible on map
  * **execute_code** - run any SQF code you want, in editor (useful for running something on composition placement) or in game
  * **extended_gear** - force facewear, face, insignia and other on a player avatar
  * **insta_osd** - print nearest town/village/etc. on-screen when the game starts
  * **kill_on_jip** - kill a player on JIP, a more gruesome alternative to teleport, for one-life missions
  * **locality_transfer** - transfer units to a client / HC on mission start, doesn't work too reliably because Arma
  * **move_respawn** - moves the respawn_\* marker to the location of this module - unlike the marker, this works in 3D! (use for battleships)
  * **paper_map** - prevents magical map marker sharing, except for a defined radius around the author
  * **persistent_callsign** - useful for compositions as Arma likes to reset callsigns in editor all the time; pre-set in group attributes, Tools menu to copy it to callsign field
  * **playable_ai** - if playing with AI in player slots, order the AI to stop, hold fire, go prone, etc. to avoid acting stupid, useful on stealth missions
  * **remove_ace_eh** - selectively removes ACE's Medical HandleDamage Event Handler, leaving the engine to handle damage, helping with lag in MP
  * **simple_object** - adds a "Simple Object (universal)" checkbox that works with any object, not just the BI-approved ones
  * **stay_and_watch** - adds two checkboxes to soldiers making them (MP-safe) stay in place (disabled PATH) and look a certain way, even in a group
  * **team_colors** - pre-defines unit colors in a group, works with sthud or vanilla command bar
  * **teleport_on_jip** - teleports any players who Join-In-Progress to where you place this module
  * **validate_mission** - various sanity checks under Tools menu (bad ACRE2 radios, overloaded units, etc.), paste result in notepad for examination
  * **menu** - other tiny items under the top menubar -> Tools that aren't part of other editor_extensions
    * **Fill in Role Description** - a quick way to make sensible unit lobby names from unit classname and group callsign, handy for custom callsigns
* **functions** - miscellaneous functions, used by some other addons in this repository, but also usable by external scripts
* **grasskeys** - CBA configurable hotkeys for setting terrain complexity (and hiding grass because AI cheats too)
* **insta_arsenal** - Vanilla or ACE Arsenal through a CBA keybind, anywhere in SP, or for any Zeus in MP
* **insta_zeus** - Zeus (Curator) anytime, anywhere in SP, or for host / logged in admin in MP, no editor support needed
* **join_group** - vanilla action to join another player's group or (if leader) make another player of own group a leader
* **loadout_copier** - copy/pastes loadout in `getUnitLoadout` format to/from clipboard using a keybind
  * works in Eden editor, Zeus and in 1st/3rd person (separate keybind for convenience)
  * uses clipboard in Eden or singleplayer, internal variable in MP due to Arma safety limitations
    * in hosted MP and [if you're the server](https://community.bistudio.com/wiki/copyToClipboard), copy outputs to clipboard in addition to variable, for debugging
* **map_trackers** - group map tracking using NATO symbols + single-soldier tracking using soldier map icons
* **marker_enh** - map markers enhanced, rotating via shift+drag, moving via alt+drag
* **misc_tiny_configs** - various Config structure tweaks and (mostly) fixes
  * **better_video_settings** - extends view distance sliders, adds greater PiP range dropdown items, etc.
  * **bright_flares** - Arma lighting update broke all lighting, this makes flares at least somewhat usable again
  * **bright_flashlight** - same, but for the default vanilla flashlight; also fix light intensity being different for self vs others
  * **cfglights_fixes** - various CfgLights tweaks to fix fireplaces / grenade flashes / etc. after Arma 3 v1.60+
  * **collapsed_3den** - Eden editor has BLUFOR->NATO->Men expanded by default, this collapses it (presuming you want modded units instead)
  * **difficulties** - misc Arma difficulty (Regular/Veteran) tweaks for convenience, no effect when Custom is used
  * **dummy_mission_deps** - provides legacy entries for mission addons[], so older/existing missions load without errors
  * **flag_insignia** - vanilla "country flags" used for map markers, but now available as uniform insignia
  * **invisible_spotter** - floating invisible unit capable of soldier-like target spotting, to be grouped into an existing AI group
  * **max_gun_elev** - no angle limitation on soldier aiming upwards/downwards
  * **portable_boat** - a boat in a backpack, what more do you want? .. unpack/repack like a mortar, cool for specop missions
  * **puffy_smoke** - smoke hand/rifle grenades are slightly better, but not as cartoonish as ACE optionals/particles
  * **rhs_flashlighs** - like bright_flashlight tweak for WMX/2DP RHS flashlights (some guns don't take vanilla flashlight)
  * **rhs_suppressors** - like suppressors tweak, but for rhs M4/AK/etc. suppressors
  * **rhs_vanilla_ammo** - like smoke_bounce tweak, by making RHS UGLs use vanilla shells (when fired, not magazines)
  * **sight_alignment** - introduce more pronounced iron sight / red dot misalignment when moving the weapon around
  * **silent_op** - special "Silent Operative" and "Silent Operative (Expert)" units (under CIV)
    * have much quieter footstep sounds and are nearly invisible to AI without NVGs during dusk/dawn/night
    * the Expert variant is highly trained, can hack UAVs, is medic/engineer, can bury bodies like in Operation Flashpoint!
    * to use, (1) place any blue/red/green soldier, (2) place SilentOP, (3) group-link SilentOp to b/r/g soldier, (4) delete original b/r/g soldier (just the soldier icon, not group icon), (5) SilentOp is now blue/red/green
  * **smoke_bounce** - tone down UGL smoke bounce on impact, they're not rubber balls anymore
  * **stamina_tweak** - making vanilla stamina system more realistic
  * **suppressors** - make various weapon suppressors much more effective, to compensate for AI hearing through walls
    * by loudness: 9.3mm + 8.6mm (.338) > 7.62mm > 6.5mm + 5.8mm > 5.56mm > 9mm
  * **view_distance** - slightly increase default 1600m hard limit in MP to 4000m
* **nightvision** - make all NVGs fullscreen (your display already has FOV=70, so chill with realism), add grain/blur/colorcorrect
* **no_neg_rating** - avoids mistreatment by the engine (cannot enter friendly vehicles) after friendly fire
* **player_novoice** - disable player contact reports, shouting when suppressed, reporting injury, etc.
* **quiet_vehicles** - lower volume in vehicles for easier direct speech communication
* **static_line** - organized group jumping, initiated by pilot/grplead, parachute not provided (you need to have one already)

Optionals
---------

* **force_video_settings** - force 1.0 brightness and contrast, to limit cheating when playing without NVGs

ACE Compatibility Notes
-----------------------

These features automatically disable themselves (even if CBA settings checkbox
says Enabled) to not conflict with almost-identical ACE/ACEX functionality.
The idea is that you can configure both (ie. keybinds) and the ACE one will get
used when you're playing with ACE and the additions one when not.

* acre_unconscious
  * checks for ACE Medical
* door_keybind
  * checks for ACE Interaction
* join_group
  * checks for ACE Interaction
* marker_enh
  * checks for ACE Map (Markers)
* misc_tiny_configs / puffy_smoke
  * ACE optionals/particles overrides it when in use
* misc_tiny_configs / stamina_tweak
  * ACE disables vanilla stamina completely, so it shouldn't conflict
* no_neg_rating
  * checks for ACE Interaction
* player_novoice
  * checks for ACE's own ACE_NoVoice
* quiet_vehicles
  * checks for ACEX Volume

Server settings
---------------

Note that the ai/dynamic_skill addon requires [specific Arma3Profile settings](addons/ai/dynamic_skill/README.md)
to work correctly.

In addition, there is some vanilla functionality that can serve as replacement
for some ACE features that you might not be aware of. See the "Server difficulty
profile example" under [server.armaprofile](https://community.bistudio.com/wiki/server.armaprofile#Arma_3)
and [Arma 3 Difficulty Menu](https://community.bistudio.com/wiki/Arma_3_Difficulty_Menu)
for the various possible settings (some not seen in the example).

The notable `.Arma3Profile` options that stand out:

* `groupIndicators` as a vanilla version of ShackTac's indicators
* `tacticalPing` as an alternative to ACE pointing
* `weaponInfo`, `stanceIndicator`, etc. as alternative to ACE UI hiding settings
* `thirdPersonView` as alternative to ACE disablement of 3rd person
* `mapContentFriendly` (with `...Enemy` set to `0`) as simple vanilla soldier tracking
* `autoReport` as an in-engine alternative to ACE setting `NoVoice` on all players

If you want a full example of server `.Arma3Profile`, you can also take a look
at my [self-hosted dedicated server repo](https://github.com/freghar/arma3dedicated)
that supports all these and their 0/1/2 values (unlike TADST) and also never
overwrites your config (unlike TADST). :)

Some notable `server.cfg` options:

* `verifySignatures = 3` is an undocumented value that enforces 1:1 exact modset
  between the server and all clients, incl. mod ordering
  * decent alternative to ACE PBO checking

description.ext settings
------------------------

Like the `.Arma3Profile` above, these are not strictly needed for the additions,
but may be useful for reference in general.

See [BI wiki page](https://community.bistudio.com/wiki/Description.ext) for
a full list.

* `class CfgUnitInsignia` may be useful for a custom "extended gear" insignia
  * re-load the mission in Eden after saving `description.ext`, it will appear
    in the list of insignia in soldier attributes
* reasonable revive settings (here or in Eden)

      reviveMode = 1;
      reviveUnconsciousStateMode = 0;
      reviveRequiredTrait = 0;
      reviveRequiredItems = 2;
      reviveRequiredItemsFakConsumed = 1;
      reviveDelay = 60;
      reviveMedicSpeedMultiplier = 3;
      reviveForceRespawnDelay = 3;
      reviveBleedOutDelay = 600;
