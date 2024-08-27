const std = @import("std");
const sage = @import("sage");

pub fn main() !void {
    var application = sage.app {
        .entry = &entry,
        .callstack = null,
        .window = null,
    };

    try application.run();
}

fn entry() void {
    std.debug.print("Hello, World!\n", .{});
}
