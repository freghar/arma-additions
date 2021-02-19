#define FLASHLIGHT_VANILLA_DEFAULTS \
    color[] = {180,160,130}; \
    ambient[] = {0.9,0.81,0.7}; \
    size = 1; \
    position = "flash dir"; \
    direction = "flash"; \
    useFlare = 1; \
    scale[] = {0};

/*
 * disable Attenuation as it is bugged for light sources since Arma 3 lighting
 * update - it displays very differently on the client owning the light
 * compared to other clients
 */

#define FLASHLIGHT_NEAR \
    dayLight = 1; \
    flareSize = 0.05; \
    intensity = 15; \
    innerAngle = 1; \
    outerAngle = 240; \
    coneFadeCoef = 14; \
    flareMaxDistance = 100; \
    class Attenuation { \
        start = 0; \
        constant = 0; \
        linear = 0; \
        quadratic = 0; \
        hardLimitStart = 50; \
        hardLimitEnd = 100; \
    };

#define FLASHLIGHT_MIDRANGE \
    dayLight = 1; \
    flareSize = 0.3; \
    intensity = 600; \
    innerAngle = 1; \
    outerAngle = 80; \
    coneFadeCoef = 8; \
    flareMaxDistance = 200; \
    class Attenuation { \
        start = 0; \
        constant = 0; \
        linear = 0; \
        quadratic = 0; \
        hardLimitStart = 50; \
        hardLimitEnd = 300; \
    };

#define FLASHLIGHT_FAR \
    dayLight = 1; \
    flareSize = 0.3; \
    intensity = 2500; \
    innerAngle = 1; \
    outerAngle = 15; \
    coneFadeCoef = 2; \
    flareMaxDistance = 400; \
    class Attenuation { \
        start = 0; \
        constant = 0; \
        linear = 0; \
        quadratic = 0; \
        hardLimitStart = 200; \
        hardLimitEnd = 400; \
    };
