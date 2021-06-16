if (isNil "a3aa_settings_initialized") exitWith {};
if (!a3aa_grasskeys_enable) exitWith {};

switch (_this) do {
    case "low": {
        if (a3aa_grasskeys_hidegrass) then {
            setTerrainGrid 50;
        } else {
            setTerrainGrid 47;
        };
    };
    case "standard": {
         setTerrainGrid 25;
    };
    case "high": {
         setTerrainGrid 12.5;
    };
    case "veryhigh": {
         setTerrainGrid 6.25;
    };
    case "ultra": {
         setTerrainGrid 3.125;
    };
};
