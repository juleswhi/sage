const std = @import("std");
const sage = @import("sage");
const log = @import("sage").log;
const ev = @import("sage").event;
const glfw = @import("mach-glfw");

pub fn main() !void {
    _ = init() catch unreachable;

    const alloc = std.heap.page_allocator;

    _ = try ev.new(ev.event_type.AppTick, "KEY_PRESSED", &alloc);
}

fn entry() void {}

pub fn init() !void {
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
