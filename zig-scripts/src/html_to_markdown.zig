const std = @import("std");

fn convert_file(allocator: std.mem.Allocator, file_path: []const u8, stdout_writer: anytype) !void {
    const file = std.fs.cwd().openFile(file_path, .{ .mode = .read_only }) catch |err| {
        std.debug.print("Error opening file: {}\n", .{err});
        std.process.exit(1);
    };
    defer file.close();

    const MAX_FILE_LEN = 50_000_000;
    const file_content = file.readToEndAlloc(allocator, MAX_FILE_LEN) catch |err| {
        std.debug.print("Error reading file {s}: {}\n", .{ file_path, err });
        std.process.exit(1);
    };
    defer allocator.free(file_content);

    try convert_html(allocator, file_content, stdout_writer);
}

fn convert_html(allocator: std.mem.Allocator, html_content: []const u8, stdout_writer: anytype) !void {
    const MAX_OUTPUT_LEN = 50_000_000;
    const argv = [_][]const u8{
        "pandoc",
        "-f",
        "html",
        "-t",
        "markdown_strict-raw_html-raw_attribute",
    };

    var child = std.process.Child.init(&argv, allocator);
    child.stdin_behavior = .Pipe;
    child.stdout_behavior = .Pipe;
    child.stderr_behavior = .Inherit;

    try child.spawn();

    // Write HTML content to pandoc's stdin
    if (child.stdin) |stdin| {
        try stdin.writeAll(html_content);
        stdin.close();
        child.stdin = null;
    }

    // Read markdown output from pandoc's stdout
    if (child.stdout) |stdout| {
        const markdown = try stdout.readToEndAlloc(allocator, MAX_OUTPUT_LEN);
        defer allocator.free(markdown);
        try stdout_writer.writeAll(markdown);
    }

    const term = try child.wait();
    switch (term) {
        .Exited => |code| {
            if (code != 0) {
                std.debug.print("pandoc exited with code {}\n", .{code});
                std.process.exit(1);
            }
        },
        else => {
            std.debug.print("pandoc terminated unexpectedly\n", .{});
            std.process.exit(1);
        },
    }
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
            try convert_file(allocator, arg, stdout_writer);
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
            try convert_file(allocator, owned_path, stdout_writer);
        }
        try stdout_writer.flush();
    } else {
        std.debug.print("Usage: html_to_markdown <file>...\n", .{});
        std.debug.print("   or: ... | html_to_markdown\n", .{});
        std.process.exit(1);
    }
}
