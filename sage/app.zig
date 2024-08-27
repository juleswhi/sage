const window = @import("window.zig").window;
const log = @import("log.zig");

pub const app = struct {
    entry: *const fn () void,
    callstack: ?[]*const fn() void,
    window: ?*const window,

    pub fn run(self: *app) !void {
        log.log_debug("starting entry method");
        self.entry();

        if(self.window) |w| {
            try w.init();
        }
        else {
            self.window = &window{};
            try self.window.?.init();
        }
    }
};
