const log = @import("log.zig");

pub const app = struct {
    entry: *const fn () void,
    windowed: bool,

    pub fn run(self: *const app) !void {
        if (self.windowed) {
            run_window();
        } else {
            run_console();
        }

        self.entry();

        log.log_debug("Entry started");

        while (true) {}
    }

    fn run_window() void {}

    fn run_console() void {}
};
