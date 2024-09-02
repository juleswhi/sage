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

    const gl_bindings = @import("zigglgen").generateBindingsModule(b, .{
        .api = .gl,
        .version = .@"4.1",
        .profile = .core,
        .extensions = &.{ .ARB_clip_control, .NV_scissor_exclusive },
    });

    const glfw_dep = b.dependency("mach-glfw", .{
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

    exe.root_module.addImport("sage", sage);
    exe.root_module.addImport("gl", gl_bindings);
    exe.root_module.addImport("mach-glfw", glfw_dep.module("mach-glfw"));

    sage.addImport("sage", sage);
    sage.addImport("gl", gl_bindings);
    sage.addImport("mach-glfw", glfw_dep.module("mach-glfw"));

    const run_cmd = b.addRunArtifact(exe);

    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
