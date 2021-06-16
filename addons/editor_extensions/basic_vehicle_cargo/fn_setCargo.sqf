if (!local _this) exitWith {};

if (_this getVariable ["a3aa_ee_basic_vehicle_cargo_dontclear", false]) exitWith {};

waitUntil { !isNil "a3aa_settings_initialized" };

clearWeaponCargoGlobal _this;
clearMagazineCargoGlobal _this;
clearBackpackCargoGlobal _this;
clearItemCargoGlobal _this;

if (a3aa_ee_basic_vehicle_cargo_cleanonly) exitWith {};

private _item_exists = { isClass (configFile >> "CfgWeapons" >> _this) };
private _add_if_exists = {
    params ["_box", "_item", "_count"];
    if (_item call _item_exists) then { _box addItemCargoGlobal [_item, _count] };
};
private _pick_random_glasses = {
    private _all = "true" configClasses (configFile >> "CfgGlasses");
    private _usable = _all select {
        isNull (_x >> "DLC") &&
        {isNumber (_x >> "scope")} &&
        {getNumber (_x >> "scope") >= 2} &&
        {configName _x != "None"}
    };
    configName selectRandom _usable;
};

private _is_repair_truck = {
    (getNumber (configOf _this >> "transportRepair") > 0) ||
    {getNumber (configOf _this >> "ace_repair_canRepair") > 0}
};

if (_this isKindOf "Car") then {
    if ("ACE_fieldDressing" call _item_exists) then {
        /* ACE */
        _this addItemCargoGlobal ["ACE_fieldDressing", floor random [0, 2, 8]];
        _this addItemCargoGlobal ["ACE_morphine", floor random [0, 1, 2]];
    } else {
        /* vanilla */
        _this addItemCargoGlobal ["FirstAidKit", floor random [0, 2, 8]];
    };

    if (random 100 < 1) then { _this addItemCargoGlobal ["ItemGPS", 1] };
    if (random 20 < 1) then { _this addItemCargoGlobal ["SmokeShell", floor random 4] };
    if (random 20 < 1) then { _this addWeaponCargoGlobal ["Binocular", 1] };
    if (random 10 < 1) then { [_this, "ACE_CableTie", floor random 5] call _add_if_exists };
    if (random 10 < 1) then {
        [_this, "ACE_MapTools", 1] call _add_if_exists;
        _this addItemCargoGlobal ["ItemMap", 1];
        _this addItemCargoGlobal ["ItemCompass", 1];
    };
    if (random 10 < 1) then { _this addItemCargoGlobal ["ItemWatch", 1] };
    if (random 2 < 1) then { _this addItemCargoGlobal [[] call _pick_random_glasses, 1] };
};

if (_this isKindOf "Tank" || _this isKindOf "Helicopter" || _this isKindOf "Plane" || _this isKindOf "Ship") then {
    if ("ACE_fieldDressing" call _item_exists) then {
        /* ACE */
        _this addItemCargoGlobal ["ACE_fieldDressing", floor random [4, 8, 12]];
        _this addItemCargoGlobal ["ACE_morphine", floor random [1, 2, 4]];
    } else {
        /* vanilla */
        _this addItemCargoGlobal ["FirstAidKit", floor random [4, 8, 12]];
        _this addItemCargoGlobal ["Medikit", floor random 2]; /* 0 or 1 */
    };
};

if (_this call _is_repair_truck) then {
    /* add repair toolkits / backpacks to repair trucks */
    _this addItemCargoGlobal ["ToolKit", 3];
    _this addBackpackCargoGlobal ["B_AssaultPack_rgr", 3];
    /* add extra spare tracks/wheels as well */
    if ("ACE_Wheel" call _item_exists) then {
        private _added = true;
        while {_added} do {
            ["ACE_Track", _this] call ace_cargo_fnc_loadItem;
            _added = ["ACE_Wheel", _this] call ace_cargo_fnc_loadItem;
        };
    };
};
