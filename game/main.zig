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

    var e = try ev.new(ev.event_type.AppTick, "KEY_PRESSED", &alloc);

    if(e.is_cat(sage.event.event_core.event_cat.application)) {
        log.debug("True");
    } else {
        log.debug("False");
    }

    try application.run();
}

fn entry() void {}
