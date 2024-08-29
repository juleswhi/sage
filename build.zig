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

    const raylib_dep = b.dependency("raylib-zig", .{
        .target = target,
        .optimize = optimize,
    });

    const raylib = raylib_dep.module("raylib"); // main raylib module
    const raygui = raylib_dep.module("raygui"); // raygui module
    const raylib_artifact = raylib_dep.artifact("raylib"); // raylib C library

    const vkzig_dep = b.dependency("vulkan_zig", .{
        .registry = @as([]const u8, b.pathFromRoot("vulkan/vulkan-zig/vk.zig")),
    });
    const vkzig_bindings = vkzig_dep.module("vulkan-zig");

    const sage = b.addModule("sage", .{ .root_source_file = .{ .src_path = .{ .sub_path = "sage/core.zig", .owner = b } } });
    exe.root_module.addImport("sage", sage);
    sage.addImport("sage", sage);

    exe.root_module.addImport("vulkan", vkzig_bindings);
    sage.addImport("vulkan", vkzig_bindings);

    exe.linkLibrary(raylib_artifact);
    sage.linkLibrary(raylib_artifact);
    sage.addImport("raylib", raylib);
    sage.addImport("raygui", raygui);

    const run_cmd = b.addRunArtifact(exe);

    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
