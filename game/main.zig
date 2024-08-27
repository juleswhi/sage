const std = @import("std");
const sage = @import("sage");

pub fn main() !void {
    const application = sage.app {
        .entry = &entry,
        .windowed = false,
    };

    try application.run();
    sage.log_info("Running");
}

fn entry() void {
    std.debug.print("Hello, World!\n", .{});
}
