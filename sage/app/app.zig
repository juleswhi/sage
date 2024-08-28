const window = @import("sage").window;
const log = @import("sage").log;

pub const app = struct {
    entry: *const fn () void,
    window: ?*const window,

    pub fn run(self: *app) !void {
        log.debug("starting entry method");
        self.entry();

        if (self.window) |w| {
            try w.init();
        } else {
            self.window = &window{ .x = 800, .y = 400 };
            try self.window.?.init();
        }
    }
};
