const std = @import("std");
const rl = @import("raylib");

pub const window = struct {
    x: i32,
    y: i32,

    pub fn init(self: *const window) anyerror!void {
        const screenWidth = if(self.x == undefined) 800 else self.x;
        const screenHeight = if(self.y == undefined) 800 else self.y;

        rl.initWindow(screenWidth, screenHeight, "Sage Engine");
        defer rl.closeWindow();

        rl.setTargetFPS(120);

        while (!rl.windowShouldClose()) {
            rl.beginDrawing();
            defer rl.endDrawing();


            rl.clearBackground(rl.Color.white);
        }
    }
};
