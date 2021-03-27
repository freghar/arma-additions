Validate mission
================

To add your own check, use (from a `preInit` CBA XEH):
```sqf
{
    ... your checking code here ...
} call a3aa_ee_validate_mission_register;
```

The code must return an **array of results**, consisting of one or more results,
with each result specifying:
```sqf
[
    "Name",  // shown in the result list as "Name: FAIL"
    false,   // true = passed the check, false = failed
    [],      // list of items (groups, soldiers, vehicles, objects) to be logged
    []       // lines of text to append to the result, ie. explanation
]
```

For example:
```sqf
[
    ["My first check", true, [], ["This always passes", "because I'm a nice guy."]],
    ["My second check", false, [player], ["You fail."]],
    ["Feel good check", true]
]
```

Yes, this indeed means one registered function can provide multiple results
under multiple different check names (though it can provide just one, or even
zero results, ie. if the check is not applicable).
