const std = @import("std");
const sage = @import("sage");
const log = @import("sage").log;
const ev = @import("sage").event;

pub fn main() !void {
    _ = sage.window.init() catch unreachable;

    const alloc = std.heap.page_allocator;

    _ = try ev.new(ev.event_type.AppTick, "KEY_PRESSED", &alloc);
}

fn entry() void {}
