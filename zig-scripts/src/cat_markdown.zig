const std = @import("std");

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();

    const allocator = arena.allocator();

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    if (args.len < 2) {
        std.debug.print("Please provide path to cat as an argument.\n", .{});
        std.process.exit(1);
    }

    const file_path = args[1];

    const file = std.fs.cwd().openFile(file_path, .{ .mode = .read_only }) catch |err| {
        std.debug.print("Error opening file: {}\n", .{err});
        std.process.exit(1);
    };
    defer file.close();

    const MAX_FILE_LEN = 10_000;
    const file_content = file.readToEndAlloc(allocator, MAX_FILE_LEN) catch |err| {
        std.debug.print("Error reading file: {}\n", .{err});
        std.process.exit(1);
    };
    defer allocator.free(file_content);

    std.debug.print("{s}\n```\n{s}```\n", .{ file_path, file_content });
}
