module assets;
module vglib;
module vaudio;

# --- SHADERS GROUP ---
group Shaders :: assets {
    fog       = vglib.load_shader("shaders/fog.vs", "shaders/fog.fs");
    vhs_color = vglib.load_shader("shaders/vhs.fs");
    vcr_font  = vglib.load_font("assets/VCR_OSD_MONO_1.001.ttf");
};

# --- TEXTURES GROUP ---
group Textures {
    paths = [
        "assets/Brick_16-512x512.png", "assets/wall.jpeg", "assets/building.jpg",
        "assets/yusif.jpeg", "assets/asphalt_road_3.jpg", "assets/Metal_18-512x512.png",
        "assets/Metal_18-512x512.png", "assets/Dirt_20-512x512.png"
    ];

    slots = [];

    through p :: paths -> loop {
        slots = slots + [vglib.load_texture(p)];
    };
};


# --- AUDIO GROUP ---
group Audio :: assets {
    vaudio.init_audio();
    startup  = vaudio.load_sound("assets/intro_startup.ogg");
    battle   = vaudio.load_sound("assets/battlefield.ogg");
    chatter  = vaudio.load_sound("assets/chatter.mp3");
    drone_flying = vaudio.load_sound("assets/drone-flying.ogg");
    explosion = vaudio.load_sound("assets/explosion.ogg");
    explosion_drone = vaudio.load_sound("assets/explosion_drone.ogg");
    siren = vaudio.load_sound("assets/siren.ogg");
    signal_lost = vaudio.load_sound("assets/signal_lost.ogg");

    vaudio.sound_volume(Audio.startup, 3.15);
    vaudio.sound_volume(Audio.battle, 1.9);
    vaudio.sound_volume(Audio.chatter, 3.2);
    vaudio.sound_volume(Audio.drone_flying, 0.8);
    vaudio.sound_volume(Audio.explosion, 2.9);
    vaudio.sound_volume(Audio.explosion_drone, 1.3);
    vaudio.sound_volume(Audio.siren, 1.0);
    vaudio.sound_volume(Audio.signal_lost, 1.0);
};

group Models :: assets {    
    # --- TREES ---
    tree_model = vglib.load_model("assets/tree.obj");
    tree_texture = vglib.load_texture("assets/Bark1M.jpg");
    
    vglib.set_model_texture_all(tree_model, tree_texture);
    vglib.set_alpha_discard(tree_model);

    # --- TARGETS ---
    target_model = vglib.load_model("assets/ps1_tank_2.glb");
    target_model_texture = vglib.load_texture("assets/ps1_tank_texture.png");

    vglib.set_model_texture(target_model, target_model_texture);    
};

out("LOADER: All assets, shaders and audio buffers initialized.");

deploy assets;