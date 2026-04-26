module missions;

module vglib;
module vaudio;
module vmath;

target_pos = [0.0, 0.0, 0.0];
target_radius = 80.0;
army_green = vglib.rgba(45, 65, 45, 255);

group Params :: missions {
    score = 0;
    impacts = [[0.0, 0.0]];
};

fn :: missions generate_target() {
    tx = vmath.random(-2000, 2000);
    tz = vmath.random(500, 2500); 
    ty = 0.0;
    
    target_pos = [tx, ty, tz];
}

fn :: missions init_next() {
    missions.generate_target();
}

fn :: missions update(cam_pos) {    
    if (cam_pos[1] <= 1.0) {
        dx = cam_pos[0] - target_pos[0];
        dz = cam_pos[2] - target_pos[2];
        
        dist_sq_2d = (dx*dx) + (dz*dz);

        if (dist_sq_2d < (target_radius * target_radius)) {
            Params.impacts = Params.impacts + [[target_pos[0], target_pos[2]]];

            Params.score = Params.score + 1;
            missions.generate_target();
        }
    }
}

fn :: missions draw_ui(u_col, cam_pos, camera) {
    cx = 960; cy = 540;

    # 1. RANGE yazısı
    dx = cam_pos[0] - target_pos[0];
    dz = cam_pos[2] - target_pos[2];
    dist = int64(vmath.hypot(dx, dz));
    
    vglib.text_ex(Shaders.vcr_font, "TARGET DIST: " + string(dist) + " M", 60, 220, 20, u_col);
    vglib.text_ex(Shaders.vcr_font, "TARGET COORDS : " + 
        string(target_pos[0]) + " " + 
        string(target_pos[1]) + " " + 
        string(target_pos[2]), 
        60, 250, 20, u_col);
    vglib.text_ex(Shaders.vcr_font, "STRIKES: " + string(Params.score), 60, 280, 20, vglib.rgba(255, 50, 50, 200));

    # 2. İstiqamət Oxu (Pointer)
    target_angle = vmath.degrees(vmath.atan2(target_pos[2] - cam_pos[2], target_pos[0] - cam_pos[0]));
    drone_yaw = vglib.get_yaw(camera); 
    total_angle = vmath.radians(target_angle + drone_yaw + 90.0);
    
    ptr_x = cx + vmath.cos(total_angle) * 160.0;
    ptr_y = cy + vmath.sin(total_angle) * 160.0;
    
    vglib.circle(ptr_x, ptr_y, 4.0, u_col);
    vglib.line(cx + vmath.cos(total_angle) * 140.0, cy + vmath.sin(total_angle) * 140.0, ptr_x, ptr_y, u_col);
}

fn :: missions draw_3d_marker() {
    vglib.draw_model(Models.target_model, target_pos[0], 0.0, target_pos[2], 4.0, army_green);
    vglib.line_3d(target_pos[0], 0.0, target_pos[2], target_pos[0], 500.0, target_pos[2], vglib.rgba(255, 0, 0, 100));

    through i :: 0..12 -> loop {
        ang = vmath.radians(i * 30.0);
        x1 = target_pos[0] + vmath.cos(ang) * target_radius;
        z1 = target_pos[2] + vmath.sin(ang) * target_radius;
        
        ang2 = vmath.radians((i+1) * 30.0);
        x2 = target_pos[0] + vmath.cos(ang2) * target_radius;
        z2 = target_pos[2] + vmath.sin(ang2) * target_radius;
        
        vglib.line_3d(x1, 1.0, z1, x2, 1.0, z2, vglib.RED);
    };
}