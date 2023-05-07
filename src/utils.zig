const std = @import("std");
const main = @import("main.zig");
const Cell = main.Cell;
const field_height = main.field_height;
const field_width = main.field_width;

//FIXME: field parameter wihout import field_height, field_width size
pub fn printField(field: *[field_height][field_width]Cell) void {
    std.debug.print("{s}", .{"\n"});
    for (field) |row| {
        for (row) |cell| {
            if (cell.mine == true) {
                std.debug.print("{s}", .{"*"});
            } else {
                if (cell.around > 0) {
                    std.debug.print("{d}", .{cell.around});
                } else {
                    std.debug.print("{s}", .{"_"});
                }
            }
        }
        std.debug.print("\n", .{});
    }
}
