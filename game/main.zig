const std = @import("std");
const sage = @import("sage");
const log = @import("sage").log;
const ev = @import("sage").event;
const init_glfw = @import("sage").init_glfw;

pub fn main() !void {
    const alloc = std.heap.page_allocator;
    _ = try ev.new(ev.event_type.AppTick, "KEY_PRESSED", &alloc);

    init_glfw();
}

fn entry() void {}

