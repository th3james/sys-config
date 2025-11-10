const std = @import("std");

fn cat_file(allocator: std.mem.Allocator, file_path: []const u8, stdout_writer: *std.Io.Writer) !void {
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

    try stdout_writer.print("{s}\n```\n{s}```\n", .{ file_path, file_content });
}

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();

    const allocator = arena.allocator();

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    var stdout_buffer: [4096]u8 = undefined;
    var stdout_writer_wrapper = std.fs.File.stdout().writer(&stdout_buffer);
    const stdout_writer = &stdout_writer_wrapper.interface;

    if (args.len > 1) {
        for (args[1..]) |arg| {
            try cat_file(allocator, arg, stdout_writer);
        }
        try stdout_writer.flush();
    } else if (!std.fs.File.stdin().isTty()) {
        var stdin_buffer: [4096]u8 = undefined;
        var stdin_reader_wrapper = std.fs.File.stdin().reader(&stdin_buffer);
        const stdin_reader = &stdin_reader_wrapper.interface;

        while (true) {
            const line = stdin_reader.takeDelimiterExclusive('\n') catch |err| switch (err) {
                error.EndOfStream => break,
                else => return err,
            };
            const owned_path = try allocator.dupe(u8, line);
            defer allocator.free(owned_path);
            try cat_file(allocator, owned_path, stdout_writer);
        }
        try stdout_writer.flush();
    } else {
        std.debug.print("Please provide path to cat as an argument.\n", .{});
        std.process.exit(1);
    }
}
