module config;

ruleset { dynamic_casting, warnings };

group Engine {
    screen_w = 1920;
    screen_h = 1080;
    target_fps = 75;
    app_title = "Drone FPV - Kharkiv Operation v0.1";
    is_fullscreen = true;

    # 3. Drone Physics & Flight Settings
    fly_speed = 0.45;
    rotation_speed = 0.12;
    sprint_boost = 2.0;

    # 4. Starting Coordinates (Kharkiv Map entry point)
    spawn_x = 0.0;
    spawn_y = 85.0;  # Dron havada başlayır
    spawn_z = -20.0;

    # 5. Cinematic Settings
    intro_dur = 7.0; # Saniyə ilə
    fade_speed = 3.0;  # Yazının tam alfa olması üçün keçən vaxt
    ui_glitch_duration = 2.5; # UI-ın stabilləşmə vaxtı
};

out("CONFIG: System parameters initialized successfully.");

deploy config;