const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "game",
        .root_source_file = b.path("game/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    const sage = b.addModule("sage", .{
        .root_source_file = .{
            .src_path = .{
                .sub_path = "sage/core.zig",
                .owner = b,
            },
        },
    });

    exe.linkSystemLibrary("SDL2");
    exe.linkLibC();

    exe.root_module.addImport("sage", sage);

    sage.addImport("sage", sage);

    const run_cmd = b.addRunArtifact(exe);

    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
