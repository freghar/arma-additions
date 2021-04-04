The `dynamic_skill` addon requires skillAI and precisionAI to be set to 1.0
and was tuned for `CfgAISkill` to have an absolute (full) scale.

The former is set by the `level_presets` config for the Regular and Veteran
difficulties, the latter is set by the `cfg_ai_skill` config. Both enabled by
default, so unless you replace them with your own logic, do not remove them.

If you want to use a Custom difficulty instead of Regular/Veteran, make sure
that both skillAI and precisionAI are set to 1.0 in the server's
`.Arma3Profile`, and the Custom difficulty is selected/forced by `server.cfg`.

`.Arma3Profile`:

    class DifficultyPresets
    {
        class CustomDifficulty
        {
            class Options
            {
                ...
            };
            aiLevelPreset=3;
        };
        class CustomAILevel
        {
            skillAI=1;
            precisionAI=1;
        };
    };

Note that `class CustomAILevel` is NOT inside `class CustomDifficulty` as
erroneously documented on some BI wiki pages.

`server.cfg`:

    forcedDifficulty = "custom";

See BI wiki for more info:
https://community.bistudio.com/wiki/server.armaprofile#Arma_3

...

You can also use a custom function (CODE), executed regularly on every soldier,
for figuring out what skills units should have. Simply set the dynamic skill
preset to "Custom function" and define
```sqf
a3aa_ai_dynamic_skill_custom = {
    // or whatever custom logic you want
    [0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5]
};
```
The function must return an array of numbers representing skills the evaluated
soldier should have. The array uses skill order listed on the
[BI wiki page for skill](https://community.bistudio.com/wiki/skill).
