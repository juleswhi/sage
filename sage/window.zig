const std = @import("std");
const rl = @import("raylib");

pub const window = struct {
    pub fn init(_: *const window) anyerror!void {
        const screenWidth = 800;
        const screenHeight = 450;

        rl.initWindow(screenWidth, screenHeight, "Schmane Schmengine");
        defer rl.closeWindow();

        rl.setTargetFPS(60);

        while (!rl.windowShouldClose()) {
            rl.beginDrawing();
            defer rl.endDrawing();

            rl.clearBackground(rl.Color.white);
        }
    }
};
