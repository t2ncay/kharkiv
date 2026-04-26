ruleset { dynamic_casting };

module renderer;
module vglib;

U_COL = vglib.rgba(180, 255, 180, 180);
RED_ARM = vglib.rgba(255, 50, 50, 200);
WHITE = vglib.rgba(255, 255, 255, 255);

fn :: renderer draw_drone_hud(cam_pos, run_time, glitch, off_x, off_y) {
    cx = 960 + glitch + off_x; 
    cy = 540 + off_y;
    size = 150;

    vglib.line(cx - size, cy - size, cx - size + 40, cy - size, U_COL);
    vglib.line(cx - size, cy - size, cx - size, cy - size + 40, U_COL);
    vglib.line(cx + size, cy - size, cx + size - 40, cy - size, U_COL);
    vglib.line(cx + size, cy - size, cx + size, cy - size + 40, U_COL);
    vglib.line(cx - size, cy + size, cx - size + 40, cy + size, U_COL);
    vglib.line(cx - size, cy + size, cx - size, cy + size - 40, U_COL);
    vglib.line(cx + size, cy + size, cx + size - 40, cy + size, U_COL);
    vglib.line(cx + size, cy + size, cx + size, cy + size - 40, U_COL);

    vglib.line(cx - 20, cy, cx + 20, cy, U_COL);
    vglib.line(cx, cy - 20, cx, cy + 20, U_COL);

    alt_base_x = 100 + off_x;
    alt_base_y = 400 + off_y;
    through i :: 0..10 -> loop {
        curr_y = alt_base_y + (i * 30);
        vglib.line(alt_base_x, curr_y, alt_base_x + 20, curr_y, U_COL);
        if (i % 2 == 0) {
            vglib.text_ex(Shaders.vcr_font, string(int64(cam_pos[1] + (5-i)*10)), alt_base_x - 30, curr_y - 10, 12, U_COL);
        }
    };

    comp_x = 800 + off_x;
    comp_y = 80 + off_y;
    through i :: 0..8 -> loop {
        curr_x = comp_x + (i * 40);
        vglib.line(curr_x, comp_y, curr_x, comp_y + 20, U_COL);
    };
    vglib.text_ex(Shaders.vcr_font, "219", 945, 110, 15, U_COL);
    vglib.line(960, 70, 960, 100, WHITE);

    vglib.text_ex(Shaders.vcr_font, "3 C", 60, 40, 18, U_COL);
    vglib.text_ex(Shaders.vcr_font, "AREA: 34M2", 60, 70, 18, U_COL);
    vglib.text_ex(Shaders.vcr_font, "ARM", cx - 30, cy - size - 30, 15, RED_ARM);
    vglib.text_ex(Shaders.vcr_font, "ELV: " + string(int64(cam_pos[1])) + "m", 1650 + off_x, 160 + off_y, 18, U_COL);
}

fn :: renderer draw_signal_lost(alpha) {
    box_a = int64(alpha * 220.0);
    text_a = int64(alpha * 255.0);
    sub_a = int64(alpha * 180.0);

    jx = vmath.random(-1, 1);
    jy = vmath.random(-1, 1);

    main_t = "SIGNAL LOST";
    sub_t  = "CONNECTION TERMINATED // NO FEED";

    m_size = vglib.measure_text(Shaders.vcr_font, main_t, 60);
    s_size = vglib.measure_text(Shaders.vcr_font, sub_t, 18);

    rw = m_size[0] + 100;
    rh = 160;

    vglib.rect(960 - (rw / 2), 460, rw, rh, vglib.rgba(15, 15, 15, box_a));
    vglib.text_ex(Shaders.vcr_font, main_t, 960 - (m_size[0]/2) + jx, 500 + jy, 60, vglib.rgba(255, 255, 255, text_a));
    vglib.text_ex(Shaders.vcr_font, sub_t, 960 - (s_size[0]/2) + jx, 590 + jy, 18, vglib.rgba(140, 140, 140, sub_a));
}