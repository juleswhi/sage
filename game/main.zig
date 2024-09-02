const std = @import("std");
const sage = @import("sage");
const log = @import("sage").log;
const ev = @import("sage").event;

pub fn main() !void {
    const alloc = std.heap.page_allocator;
    _ = try ev.new(ev.event_type.AppTick, "KEY_PRESSED", &alloc);

    sage.window.init_glfw("Sage Engine", 800, 400);
}

fn entry() void {}

