const std = @import("std");
const rl = @import("raylib");
const event = @import("sage").event.event;
const glfw = @import("mach-glfw");

pub const window = struct {
    title: [*:0]const u8,
    width: u32,
    height: u32,

    vsync: bool,

    event_callback: ?*fn (e: *event) void,

    w: glfw.Window,

    pub fn on_update(self: *const window, callback: *fn () void) void {
        if(callback) |cb| {
            cb();
        }

        glfw.pollEvents();
        glfw.swapBuffers(self.w);
    }

    pub fn init(title: [*:0]const u8, width: u32, height: u32, vsync: bool) window {
        glfw.setErrorCallback(errorCallback);

        if (!glfw.init(.{})) {
            std.log.err("failed to initialize GLFW: {?s}", .{glfw.getErrorString()});
            std.process.exit(1);
        }

        const w = glfw.Window.create(width, height, title, null, null, .{}) orelse {
            std.log.err("failed to create GLFW window: {?s}", .{glfw.getErrorString()});
            std.process.exit(1);
        };

        return window{
            .title = title,
            .width = width,
            .height = height,
            .w = w,
            .vsync = vsync,
            .event_callback = null,
        };
    }

    pub fn set_vsync(set: bool) void {
        if(set) {
            glfw.swapInterval(1);
        } else {
            glfw.swapInterval(0);
        }
    }

    fn errorCallback(error_code: glfw.ErrorCode, description: [:0]const u8) void {
        std.log.err("glfw: {}: {s}\n", .{ error_code, description });
    }

    fn make_current_context(win: *const glfw.Window) void {
        glfw.makeContextCurrent(win);
    }

    pub fn destroy(self: *window) void {
        self.w.destroy();
        glfw.terminate();
        glfw.makeContextCurrent(null);
    }
};
