const std = @import("std");
const window = @import("window.zig");

pub const Game = struct {
    window: bool,
};

pub fn run() !void {
    try window.init();
}
