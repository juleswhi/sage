const std = @import("std");
const rl = @import("raylib");
const event = @import("sage").event.event;
const glfw = @import("mach-glfw");

pub const window = struct {
    title: []const u8,

    width: u32,
    height: u32,

    set_event_callback: ?*fn (callback: fn (e: *const event) void) void,

    pub fn init_glfw(title: [*:0]const u8, width: u32, height: u32) void {
        glfw.setErrorCallback(errorCallback);

        if (!glfw.init(.{})) {
            std.log.err("failed to initialize GLFW: {?s}", .{glfw.getErrorString()});
            std.process.exit(1);
        }

        defer glfw.terminate();

        const w = glfw.Window.create(width, height, title, null, null, .{}) orelse {
            std.log.err("failed to create GLFW window: {?s}", .{glfw.getErrorString()});
            std.process.exit(1);
        };

        defer w.destroy();

        while (!w.shouldClose()) {
            w.swapBuffers();
            glfw.pollEvents();
        }
    }

    fn errorCallback(error_code: glfw.ErrorCode, description: [:0]const u8) void {
        std.log.err("glfw: {}: {s}\n", .{ error_code, description });
    }
};
