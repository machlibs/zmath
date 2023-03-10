const std = @import("std");

pub fn module(b: *std.Build) *std.build.Module {
    return b.createModule(.{
        .source_file = .{ .path = thisDir() ++ "/src/zmath.zig" },
    });
}

pub fn build(b: *std.build.Builder) void {
    const optimize = b.standardOptimizeOption(.{});
    const target = b.standardTargetOptions(.{});
    const tests = buildTests(b, optimize, target);

    const test_step = b.step("test", "Run zmath tests");
    test_step.dependOn(&tests.step);
}

pub fn buildTests(
    b: *std.build.Builder,
    optimize: std.builtin.OptimizeMode,
    target: std.zig.CrossTarget,
) *std.build.LibExeObjStep {
    const tests = b.addTest(.{
        .name = "zmath-tests",
        .kind = .test_exe,
        .root_source_file = .{ .path = thisDir() ++ "/src/zmath.zig" },
        .target = target,
        .optimize = optimize,
    });
    return tests;
}

pub fn buildBenchmarks(
    b: *std.build.Builder,
    target: std.zig.CrossTarget,
) *std.build.LibExeObjStep {
    const exe = b.addExecutable(.{
        .name = "benchmark",
        .root_source_file = .{ .path = thisDir() ++ "/src/benchmark.zig" },
        .target = target,
        .optimize = std.builtin.OptimizeMode.ReleaseFast,
    });
    return exe;
}

inline fn thisDir() []const u8 {
    return comptime std.fs.path.dirname(@src().file) orelse ".";
}
