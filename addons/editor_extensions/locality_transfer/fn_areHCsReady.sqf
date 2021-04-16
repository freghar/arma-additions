/*
 * return true if all passed HCs have submitted their metadata to the server
 * (called updateHCInfo at least once)
 */

private _all = keys a3aa_ee_locality_transfer_hcdata;

/* faster than iterating manually */
count _this == count (_all arrayIntersect _this);
