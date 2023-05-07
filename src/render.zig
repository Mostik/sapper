const c = @cImport({
    @cInclude("GL/gl.h");
});

pub fn drawOne() void {
    c.glBegin(c.GL_LINES);

    c.glColor3f(1.0, 1.0, 0);

    c.glVertex2f(0.25, -0.50);
    c.glVertex2f(0.50, -0.25);

    c.glVertex2f(0.50, -0.25);
    c.glVertex2f(0.50, -0.75);

    c.glEnd();
}

pub fn drawTwo() void {
    c.glBegin(c.GL_LINES);

    c.glColor3f(1.0, 1.0, 0);

    c.glVertex2f(0.25, -0.25);
    c.glVertex2f(0.75, -0.25);

    c.glVertex2f(0.75, -0.25);
    c.glVertex2f(0.75, -0.50);

    c.glVertex2f(0.75, -0.50);
    c.glVertex2f(0.25, -0.50);

    c.glVertex2f(0.25, -0.50);
    c.glVertex2f(0.25, -0.75);

    c.glVertex2f(0.25, -0.75);
    c.glVertex2f(0.75, -0.75);

    c.glEnd();
}

pub fn drawThree() void {
    c.glBegin(c.GL_LINES);

    c.glColor3f(1.0, 1.0, 0);

    c.glVertex2f(0.25, -0.25);
    c.glVertex2f(0.75, -0.25);

    c.glVertex2f(0.75, -0.25);
    c.glVertex2f(0.75, -0.75);

    c.glVertex2f(0.75, -0.50);
    c.glVertex2f(0.25, -0.50);

    c.glVertex2f(0.25, -0.75);
    c.glVertex2f(0.75, -0.75);

    c.glEnd();
}

pub fn drawFour() void {
    c.glBegin(c.GL_LINES);

    c.glColor3f(1.0, 1.0, 0);

    c.glVertex2f(0.25, -0.25);
    c.glVertex2f(0.25, -0.50);

    c.glVertex2f(0.75, -0.25);
    c.glVertex2f(0.75, -0.75);

    c.glVertex2f(0.75, -0.50);
    c.glVertex2f(0.25, -0.50);

    c.glEnd();
}

pub fn drawFive() void {
    c.glBegin(c.GL_LINES);

    c.glColor3f(1.0, 1.0, 0);

    c.glVertex2f(0.25, -0.25);
    c.glVertex2f(0.75, -0.25);

    c.glVertex2f(0.25, -0.25);
    c.glVertex2f(0.25, -0.50);

    c.glVertex2f(0.75, -0.50);
    c.glVertex2f(0.25, -0.50);

    c.glVertex2f(0.75, -0.50);
    c.glVertex2f(0.75, -0.75);

    c.glVertex2f(0.25, -0.75);
    c.glVertex2f(0.75, -0.75);

    c.glEnd();
}

pub fn drawSix() void {
    c.glBegin(c.GL_LINES);

    c.glColor3f(1.0, 1.0, 0);

    c.glVertex2f(0.25, -0.25);
    c.glVertex2f(0.75, -0.25);

    c.glVertex2f(0.25, -0.25);
    c.glVertex2f(0.25, -0.75);

    c.glVertex2f(0.75, -0.50);
    c.glVertex2f(0.25, -0.50);

    c.glVertex2f(0.75, -0.50);
    c.glVertex2f(0.75, -0.75);

    c.glVertex2f(0.25, -0.75);
    c.glVertex2f(0.75, -0.75);

    c.glEnd();
}

pub fn drawSeven() void {
    c.glBegin(c.GL_LINES);

    c.glColor3f(1.0, 1.0, 0);

    c.glVertex2f(0.25, -0.25);
    c.glVertex2f(0.75, -0.25);

    c.glVertex2f(0.75, -0.25);
    c.glVertex2f(0.75, -0.75);

    c.glEnd();
}

pub fn drawEight() void {
    c.glBegin(c.GL_LINES);

    c.glColor3f(1.0, 1.0, 0);

    c.glVertex2f(0.25, -0.25);
    c.glVertex2f(0.75, -0.25);

    c.glVertex2f(0.25, -0.50);
    c.glVertex2f(0.75, -0.50);

    c.glVertex2f(0.25, -0.75);
    c.glVertex2f(0.75, -0.75);

    c.glVertex2f(0.25, -0.25);
    c.glVertex2f(0.25, -0.75);

    c.glVertex2f(0.75, -0.25);
    c.glVertex2f(0.75, -0.75);

    c.glEnd();
}

pub fn drawMine() void {
    c.glBegin(c.GL_QUADS);
    c.glColor3f(1.0, 0.0, 0);
    c.glVertex2f(0.25, -0.25);
    c.glVertex2f(0.75, -0.25);
    c.glVertex2f(0.75, -0.75);
    c.glVertex2f(0.25, -0.75);
    c.glEnd();
}

pub fn drawCellOpen() void {
    c.glBegin(c.GL_QUADS);
    c.glColor3f(0.75, 0.75, 0.75);
    c.glVertex2f(0.0, 0.0);
    c.glVertex2f(1.0, 0.0);
    c.glVertex2f(1.0, -1.0);

    c.glColor3f(0.85, 0.85, 0.85);
    c.glVertex2f(0.0, -1.0);
    c.glEnd();
}

pub fn drawCellClose() void {
    c.glBegin(c.GL_QUADS);
    c.glColor3f(0.55, 0.55, 0.55);
    c.glVertex2f(0.0, 0.0);
    c.glVertex2f(1.0, 0.0);
    c.glVertex2f(1.0, -1.0);

    c.glColor3f(0.65, 0.65, 0.65);
    c.glVertex2f(0.0, -1.0);
    c.glEnd();
}

pub fn drawFlag() void {
    c.glBegin(c.GL_QUADS);

    c.glColor3f(1.0, 0.6, 0.4);
    c.glVertex2f(0.25, -0.25);
    c.glVertex2f(0.35, -0.25);
    c.glVertex2f(0.35, -0.75);
    c.glVertex2f(0.25, -0.75);

    c.glEnd();

    c.glBegin(c.GL_TRIANGLES);

    c.glColor3f(1.0, 0.0, 0);
    c.glVertex2f(0.25, -0.25);
    c.glVertex2f(0.75, -0.25);
    c.glVertex2f(0.25, -0.50);

    c.glEnd();
}
