/*
 * flag insignia - expose vanilla CfgMarkers country flags as CfgUnitInsignia
 */

class CfgPatches {
    class a3aa_mtc_flag_insignia {
        units[] = {};
        weapons[] = {};
        magazines[] = {};
        requiredAddons[] = {};
    };
};

#define CONCAT2(a,b) a##b
#define CONCAT3(a,b,c) a##b##c
#define QUOTE(s) #s
#define FLAG_INSIGNIA(name) \
    class CONCAT2(a3aa_mtc_flag_insignia_,name) { \
        displayName = QUOTE(CONCAT2(name, flag)); \
        texture = QUOTE(CONCAT3(\A3\ui_f\data\map\markers\flags\,name,_ca.paa)); \
        textureVehicle = ""; \
        material = "\A3\Ui_f\data\GUI\Cfg\UnitInsignia\default_insignia.rvmat"; \
    }

class CfgUnitInsignia {
    FLAG_INSIGNIA(NATO);
    FLAG_INSIGNIA(CSAT);
    FLAG_INSIGNIA(AAF);
    FLAG_INSIGNIA(Altis);
    FLAG_INSIGNIA(AltisColonial);
    FLAG_INSIGNIA(FIA);
    FLAG_INSIGNIA(EU);
    FLAG_INSIGNIA(UN);
    FLAG_INSIGNIA(Belgium);
    FLAG_INSIGNIA(Canada);
    FLAG_INSIGNIA(Catalonia);
    FLAG_INSIGNIA(Croatia);
    FLAG_INSIGNIA(CzechRepublic);
    FLAG_INSIGNIA(Denmark);
    FLAG_INSIGNIA(France);
    FLAG_INSIGNIA(Georgia);
    FLAG_INSIGNIA(Germany);
    FLAG_INSIGNIA(Greece);
    FLAG_INSIGNIA(Hungary);
    FLAG_INSIGNIA(Iceland);
    FLAG_INSIGNIA(Italy);
    FLAG_INSIGNIA(Luxembourg);
    FLAG_INSIGNIA(Netherlands);
    FLAG_INSIGNIA(Norway);
    FLAG_INSIGNIA(Poland);
    FLAG_INSIGNIA(Portugal);
    FLAG_INSIGNIA(Slovakia);
    FLAG_INSIGNIA(Slovenia);
    FLAG_INSIGNIA(Spain);
    FLAG_INSIGNIA(UK);
    FLAG_INSIGNIA(USA);
};
