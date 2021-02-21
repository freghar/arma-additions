if (is3DEN) exitWith {};
private _briefingfor = _this getVariable "a3aa_ee_briefing_briefingfor";
private _contents = [
    ["Situation", _this getVariable "a3aa_ee_briefing_situation"],
    ["Mission", _this getVariable "a3aa_ee_briefing_mission"],
    ["Execution", _this getVariable "a3aa_ee_briefing_execution"],
    ["Admin & Logistics", _this getVariable "a3aa_ee_briefing_admin_logistics"],
    ["Command & Signal", _this getVariable "a3aa_ee_briefing_command_signal"]
];
/* filter out empty */
_contents = _contents select { (_x select 1) != "" };

[_briefingfor, _contents]
    remoteExec ["a3aa_ee_briefing_fnc_makeDiaryEntries", 0, true];

/*
 * we could keep the module unit around for JIP clients to check whether they
 * have been synchronized with it in the editor, but it turns out that sync
 * connections don't work with JIP even if you don't delete the module
 * - apparently, JIP spawns a completely different unit, the module is still
 *   synced to the corpse, so no jazz, just optimize/delete it
 */
deleteVehicle _this;
