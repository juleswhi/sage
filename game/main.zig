const std = @import("std");
const sage = @import("sage");
const log = @import("sage").log;
const ev = @import("sage").event;

pub fn main() !void {
    var application = sage.app{
        .entry = &entry,
        .window = &sage.window{ .x = 1000, .y = 1000 },
    };

    const alloc = std.heap.page_allocator;

    _ = try ev.new(ev.event_type.AppTick, "KEY_PRESSED", &alloc);

    try application.run();
}

fn entry() void {}
