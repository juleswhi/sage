const std = @import("std");
const window = @import("window.zig");

pub fn run() !void {
    try window.init();
}
