const std = @import("std");

fn cat_file(allocator: std.mem.Allocator, file_path: []const u8) !void {
    const file = std.fs.cwd().openFile(file_path, .{ .mode = .read_only }) catch |err| {
        std.debug.print("Error opening file: {}\n", .{err});
        std.process.exit(1);
    };
    defer file.close();

    const MAX_FILE_LEN = 50_000;
    const file_content = file.readToEndAlloc(allocator, MAX_FILE_LEN) catch |err| {
        std.debug.print("Error reading file {s}: {}\n", .{ file_path, err });
        std.process.exit(1);
    };
    defer allocator.free(file_content);

    const stdout = std.io.getStdOut().writer();
    try stdout.print("{s}\n```\n{s}```\n", .{ file_path, file_content });
}

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();

    const allocator = arena.allocator();

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    if (args.len > 1) {
        for (args[1..]) |arg| {
            try cat_file(allocator, arg);
        }
    } else if (!std.io.getStdIn().isTty()) {
        const stdin = std.io.getStdIn().reader();
        var buf_reader = std.io.bufferedReader(stdin);
        var reader = buf_reader.reader();

        const MAX_NAME_LEN = 4096;
        var buf: [MAX_NAME_LEN]u8 = undefined;
        while (try reader.readUntilDelimiterOrEof(&buf, '\n')) |line| {
            const owned_path = try allocator.dupe(u8, line);
            defer allocator.free(owned_path);
            try cat_file(allocator, owned_path);
        }
    } else {
        std.debug.print("Please provide path to cat as an argument.\n", .{});
        std.process.exit(1);
    }
}
