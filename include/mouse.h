#ifndef MOUSE_H
#define MOUSE_H

void moveMouse(int x, int y);
void moveMouseRel(int dx, int dy);
void smoothMoveMouse(int x, int y);
void clickMouse(const char* button = "left");
void doubleClickMouse();
void rightClickMouse();
void mouseDown(const char* button = "left");
void mouseUp(const char* button = "left");
void dragMouseTo(int x, int y);
void scrollMouse(int lines);

#endif