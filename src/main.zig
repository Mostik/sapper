const std = @import("std");
const util = @import("utils.zig");
const render = @import("render.zig");

const c = @cImport({
    @cInclude("GLFW/glfw3.h");
});

pub const Cell = struct {
    mine: bool = false,
    flag: bool = false,
    open: bool = false,
    around: i32 = 0,
};

const Mouse = struct {
    x: f64,
    y: f64,
};

var window_height: c_int = 600;
var window_width: c_int = 600;

pub const field_height = 15;
pub const field_width = 15;

var field: [field_height][field_width]Cell = undefined;

var mines: u32 = 15;

var mouse: Mouse = Mouse{ .x = 0, .y = 0 };

pub fn init() !void {
    field = std.mem.zeroes([field_height][field_width]Cell);
    var prng = std.rand.DefaultPrng.init(blk: {
        var seed: u64 = undefined;
        try std.os.getrandom(std.mem.asBytes(&seed));
        break :blk seed;
    });
    const rand = prng.random();

    var i: i32 = 0;
    while (i < mines) : (i += 1) {
        const row = rand.intRangeAtMost(u32, 0, field_height - 1);
        const cell = rand.intRangeAtMost(u32, 0, field_width - 1);
        if (field[row][cell].mine == true) {
            i -= 1;
        } else {
            field[row][cell].mine = true;

            var ai: i32 = @intCast(i32, row) - 1;
            while (ai <= row + 1) : (ai += 1) {
                var aj: i32 = @intCast(i32, cell) - 1;
                while (aj <= cell + 1) : (aj += 1) {
                    if (ai >= 0 and ai <= field_height - 1) {
                        if (aj >= 0 and aj <= field_width - 1) {
                            field[@intCast(u32, ai)][@intCast(u32, aj)].around += 1;
                        }
                    }
                }
            }
        }
    }
}

pub fn pixelsToCell(x: f64, y: f64) struct { u32, u32 } {
    var step_x = @intToFloat(f64, window_width) / @intToFloat(f64, field_width);
    var cell_x_int = @floatToInt(i32, x / step_x);
    var cells_x: i32 = cell_x_int;

    var step_y = @intToFloat(f64, window_height) / @intToFloat(f64, field_height);
    var cell_y_int = @floatToInt(i32, y / step_y);
    var cells_y: i32 = cell_y_int;

    return .{ @intCast(u32, cells_y), @intCast(u32, cells_x) };
}

pub fn openEmptyCells(cell_y: i32, cell_x: i32) void {
    var parent = field[@intCast(u32, cell_y)][@intCast(u32, cell_x)];

    if (parent.around == 0 and parent.open == false) {
        field[@intCast(u32, cell_y)][@intCast(u32, cell_x)].open = true;

        var row = cell_y - 1;
        while (row <= cell_y + 1) : (row += 1) {
            var cell = cell_x - 1;
            while (cell <= cell_x + 1) : (cell += 1) {
                if (row >= 0 and row < field_height) {
                    if (cell >= 0 and cell < field_width) {
                        openEmptyCells(row, cell);
                    }
                }
            }
        }
    } else {
        field[@intCast(u32, cell_y)][@intCast(u32, cell_x)].open = true;
    }
}

pub fn pixelsToOpenGL(x: f64, y: f64) struct { f64, f64 } {
    var opengl_x = 2.0 / @intToFloat(f64, window_width) * x;
    if (opengl_x < 1.0) {
        opengl_x = -1.0 + opengl_x;
    } else {
        opengl_x = opengl_x - 1.0;
    }

    var opengl_y = 1.0 - (2.0 / @intToFloat(f64, window_height) * y);
    return .{ opengl_x, opengl_y };
}

pub fn handlerMouse(window: ?*c.GLFWwindow, button: c_int, action: c_int, _: c_int) callconv(.C) void {
    if (button == c.GLFW_MOUSE_BUTTON_LEFT and action == 0) {
        c.glfwGetCursorPos(window, &mouse.x, &mouse.y);

        var cell = pixelsToCell(mouse.x, mouse.y);

        openEmptyCells(@intCast(i32, cell[0]), @intCast(i32, cell[1]));
    }

    if (button == c.GLFW_MOUSE_BUTTON_RIGHT and action == 0) {
        c.glfwGetCursorPos(window, &mouse.x, &mouse.y);

        var cell = pixelsToCell(mouse.x, mouse.y);

        field[cell[0]][cell[1]].flag = !field[cell[0]][cell[1]].flag;
    }
}

pub fn handlerKeyboard(_: ?*c.GLFWwindow, key: c_int, _: c_int, action: c_int, _: c_int) callconv(.C) void {
    if (key == c.GLFW_KEY_R and action == 0) {
        _ = init() catch |err| {
            std.debug.print("{}", .{err});
        };

        util.printField(&field);
    }
}

pub fn main() !void {
    _ = c.glfwInit();

    var window = c.glfwCreateWindow(window_width, window_height, "Sapper", null, null);
    _ = c.glfwSetKeyCallback(window, &handlerKeyboard);
    _ = c.glfwSetMouseButtonCallback(window, &handlerMouse);

    c.glfwMakeContextCurrent(window);

    try init();

    util.printField(&field);

    while (c.glfwWindowShouldClose(window) == 0) {
        c.glfwPollEvents();
        c.glClearColor(1.0, 1.0, 1.0, 1.0);
        c.glClear(c.GL_COLOR_BUFFER_BIT);
        c.glLoadIdentity();
        c.glScalef(2.0 / @intToFloat(f32, field_height), 2.0 / @intToFloat(f32, field_width), 1);
        c.glTranslatef(-@intToFloat(f32, field_height) * 0.5, @intToFloat(f32, field_width) * 0.5, 0);

        drawField();

        c.glfwSwapBuffers(window);
    }
}

fn drawField() void {
    for (0..field_height) |row| {
        for (0..field_width) |cell| {
            c.glPushMatrix();

            c.glTranslatef(@intToFloat(f32, cell), -@intToFloat(f32, row), 0);

            if (field[row][cell].open == true) {
                render.drawCellOpen();
                if (field[row][cell].mine == true) {
                    render.drawMine();
                } else {
                    if (field[row][cell].around == 1) {
                        render.drawOne();
                    }
                    if (field[row][cell].around == 2) {
                        render.drawTwo();
                    }
                    if (field[row][cell].around == 3) {
                        render.drawThree();
                    }
                    if (field[row][cell].around == 4) {
                        render.drawFour();
                    }
                    if (field[row][cell].around == 5) {
                        render.drawFive();
                    }
                    if (field[row][cell].around == 6) {
                        render.drawSix();
                    }
                    if (field[row][cell].around == 7) {
                        render.drawSeven();
                    }
                    if (field[row][cell].around == 8) {
                        render.drawEight();
                    }
                }
            } else {
                render.drawCellClose();
                if (field[row][cell].flag == true) {
                    render.drawFlag();
                }
            }

            c.glPopMatrix();
        }
    }
}
