const std = @import("std");
const rl = @import("raylib");
const event = @import("sage").event.event;
const glfw = @import("mach-glfw");

pub const window = struct {
    title: []const u8,

    width: u32,
    height: u32,

    set_event_callback: ?fn (callback: fn (e: *const event) void) void,
};

pub fn init_glfw() *const window {
    glfw.setErrorCallback(errorCallback);
    if (!glfw.init(.{})) {
        std.log.err("failed to initialize GLFW: {?s}", .{glfw.getErrorString()});
        std.process.exit(1);
    }
    defer glfw.terminate();

    // Create our window
    const w = glfw.Window.create(400, 400, "Sage Engine", null, null, .{}) orelse {
        std.log.err("failed to create GLFW window: {?s}", .{glfw.getErrorString()});
        std.process.exit(1);
    };

    defer w.destroy();

    // Wait for the user to close the window.
    while (!w.shouldClose()) {
        w.swapBuffers();
        glfw.pollEvents();
    }
}

fn errorCallback(error_code: glfw.ErrorCode, description: [:0]const u8) void {
    std.log.err("glfw: {}: {s}\n", .{ error_code, description });
}
