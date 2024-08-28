const std = @import("std");
const vec2 = @import("sage").engine.vec2;
const al = @import("std").ArrayList;

pub fn new(e_type: event_type, name: []const u8, alloc: *const std.mem.Allocator) !event {
    var cats: al(event_cat) = try e_type.get_cat(alloc.*);
    defer cats.deinit();
    return event{
        .event_type = e_type,
        .event_cats = try cats.toOwnedSlice(),
        .name = name,
        .handled = false,
    };
}

pub const event = struct {
    event_type: event_type,
    event_cats: []event_cat,

    name: []const u8,
    handled: bool,

    pub fn is_cat(self: *event, cat: event_cat) bool {
        for(self.event_cats) |c| {
            if(c == cat) {
                return true;
            }
        }
        return false;
    }
};

pub const event_type = enum {
    WindowClose,
    WindowResize,
    WindowFocus,
    WindowLostFocus,
    WindowMoved,

    AppTick,
    AppUpdate,
    AppRender,

    KeyPressed,
    KeyReleased,

    MouseButtonPressed,
    MouseButtonReleased,
    MouseMoved,
    MouseScrolled,

    pub fn get_cat(self: *const event_type, alloc: std.mem.Allocator) !al(event_cat) {
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
            .KeyPressed => try list.appendSlice(&[_]event_cat{ event_cat.input, event_cat.keyboard }),
            .KeyReleased => try list.appendSlice(&[_]event_cat{ event_cat.input, event_cat.keyboard }),
            .MouseButtonPressed => try list.appendSlice(&[_]event_cat{ event_cat.input, event_cat.mouse }),
            .MouseButtonReleased => try list.appendSlice(&[_]event_cat{ event_cat.input, event_cat.mouse }),
            .MouseMoved => try list.appendSlice(&[_]event_cat{ event_cat.input, event_cat.mouse }),
            .MouseScrolled => try list.appendSlice(&[_]event_cat{ event_cat.input, event_cat.mouse }),
        }

        return list;
    }
};

pub const event_cat = enum(u8) {
    application,
    input,
    keyboard,
    mouse,

    pub fn toi(self: *const event_cat) u8 {
        return switch (self) {
            .application => 0,
            .input => 1,
            .keyboard => 2,
            .mouse => 3,
        };
    }
};
