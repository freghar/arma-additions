class CfgPatches {
    class a3aa_ee_shared {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {
            "a3aa_functions",
            "3den"
        };
    };
};

class Cfg3DEN {
    /* expand Transformation on Logic by default, so that Size config
     * for area-using modules can be seen */
    class Logic {
        class AttributeCategories {
            class Transformation {
                collapsed = 0;
            };
        };
    };

    class Attributes {
        #include "\a3\3DEN\UI\macros.inc"
        /*
         * big edit boxes
         */
        class EditMulti3;
        class EditMulti5 : EditMulti3 {
            class Controls { class Title; class Value; };
        };
        class a3aa_ee_EditBig15 : EditMulti5 {
            h = 15 * SIZE_M * GRID_H;
            class Controls : Controls {
                class Title : Title { h = 15 * SIZE_M * GRID_H; };
                class Value : Value { h = 15 * SIZE_M * GRID_H; };
            };
        };
        /*
         * big code boxes
         */
        class EditCodeMulti5 : EditMulti5 {
            class Controls { class Title; class Value; };
        };
        class a3aa_ee_EditCode30 : EditCodeMulti5 {
            h = 30 * SIZE_XS * GRID_H;
            class Controls : Controls {
                class Title : Title { h = 30 * SIZE_XS * GRID_H; };
                class Value : Value { h = 30 * SIZE_XS * GRID_H; };
            };
        };
    };
};

class CfgFactionClasses {
    class NO_CATEGORY;
    class a3aa_ee : NO_CATEGORY {
        displayName = "A3AA";
    };
};
class CfgVehicles {
    /* without all the engine logic surrounding Module_F, we just want 3DEN
     * Attributes and init EH */
    class Logic;
    class a3aa_ee_shared_module_base : Logic {
        scope = 0;
        category = a3aa_ee;
        vehicleClass = "Modules";
        icon = "iconModule";
        class EventHandlers;
    };
};

/*
 * 3DEN menu bar, Tools, custom category
 */
class ctrlMenuStrip;
class display3DEN {
    class Controls {
        class MenuStrip : ctrlMenuStrip {
            class Items {
                class Tools {
                    items[] += { "a3aa_ee" };
                };
                class a3aa_ee {
                    text = "A3AA Tools";
                    picture = "\a3\3DEN\Data\CfgWaypoints\Scripted_ca.paa";
                    items[] = {};
                };
            };
        };
    };
};
