const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const scripts = [_][]const u8{"cat_markdown"};

    inline for (scripts) |script| {
        const exe = b.addExecutable(.{
            .name = script,
            .root_source_file = b.path("src/" ++ script ++ ".zig"),
            .target = target,
            .optimize = optimize,
        });
        b.installArtifact(exe);
    }
}
