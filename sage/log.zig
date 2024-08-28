const std = @import("std");

pub const log_type = union(enum) {
    debug,
    info,
    err,
    fatal,
};

pub fn log(l_type: log_type, msg: []const u8) void {
    std.debug.print("[ {s} ] {s}\n", .{ switch (l_type) {
        .debug => "DEBUG",
        .info => "INFO",
        .err => "ERR",
        .fatal => "FATAL",
    }, msg });
}

pub fn debug(msg: []const u8) void {
    log(.debug, msg);
}

pub fn info(msg: []const u8) void {
    log(.info, msg);
}

pub fn err(msg: []const u8) void {
    log(.err, msg);
}

pub fn fatal(msg: []const u8) void {
    log(.fatal, msg);
}
