const std = @import("std");
const event = @import("event.zig").event;

pub const event_dispatcher = struct {
    e: *const event,

    pub fn dispatch(self: *event_dispatcher, comptime T: type, func: fn (*T) bool) bool {
        if(self.e.event_type == T.getStaticType()) {
            self.e.handled = func(@ptrCast(self.e));
            return true;
        }
        return false;
    }
};
