const std = @import("std");
const vec2 = @import("sage").engine.vec2;
const al = @import("std").ArrayList;

pub fn new(e_type: event_type, name: []const u8, alloc: *const std.mem.Allocator) !event {
    var cats: al(event_cat) = try e_type.get_cat(alloc.*);
    defer cats.deinit();
    return event{
        .event_type = e_type,
        .event_cat = try cats.toOwnedSlice(),
        .name = name,
        .handled = false,
    };
}

pub const event = struct {
    event_type: event_type,
    event_cat: []event_cat,

    name: []const u8,
    handled: bool,

    pub fn is_cat(self: *event, cat: event_cat) bool {
        return (1 << self.event_cat) & (1 << cat);
    }
};

pub const event_type = union(enum) {
    WindowClose,
    WindowResize: vec2,
    WindowFocus,
    WindowLostFocus,
    WindowMoved: vec2,

    AppTick,
    AppUpdate,
    AppRender,

    KeyPressed: struct { keycode: []const u8, repeat: u32 },
    KeyReleased: struct { keycode: []const u8 },

    MouseButtonPressed: struct { buttoncode: u8 },
    MouseButtonReleased: struct { buttoncode: u8 },
    MouseMoved: vec2,
    MouseScrolled: struct { xoffset: f32, yoffset: f32 },

    pub fn get_cat(self: *const event_type, alloc: std.mem.Allocator) !std.ArrayList(event_cat) {
        var list = al(event_cat).init(alloc);
        switch (self.*) {
            .WindowClose => try list.appendSlice(&[_]event_cat{event_cat.application}),
            .WindowResize => try list.appendSlice(&[_]event_cat{event_cat.application}),
            .WindowFocus => try list.appendSlice(&[_]event_cat{event_cat.application}),
            .WindowLostFocus => try list.appendSlice(&[_]event_cat{event_cat.application}),
            .WindowMoved => try list.appendSlice(&[_]event_cat{event_cat.application}),
            .AppTick => try list.appendSlice(&[_]event_cat{event_cat.application}),
            .AppUpdate => try list.appendSlice(&[_]event_cat{event_cat.application}),
            .AppRender => try list.appendSlice(&[_]event_cat{event_cat.application}),
            .KeyPressed => try list.appendSlice(&[_]event_cat{event_cat.input, event_cat.keyboard}),
            .KeyReleased => try list.appendSlice(&[_]event_cat{event_cat.input, event_cat.keyboard}),
            .MouseButtonPressed => try list.appendSlice(&[_]event_cat{event_cat.input, event_cat.mouse}),
            .MouseButtonReleased => try list.appendSlice(&[_]event_cat{event_cat.input, event_cat.mouse}),
            .MouseMoved => try list.appendSlice(&[_]event_cat{event_cat.input, event_cat.mouse}),
            .MouseScrolled => try list.appendSlice(&[_]event_cat{event_cat.input, event_cat.mouse}),
        }

        return list;
    }
};

pub const event_cat = enum(u8) {
    application = 0,
    input = 1,
    keyboard = 2,
    mouse = 3,
};
