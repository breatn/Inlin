#include "../include/mouse.h"
#import <ApplicationServices/ApplicationServices.h>

void moveMouse(int x, int y) {
    CGWarpMouseCursorPosition(CGPointMake(x, y));
    CGAssociateMouseAndMouseCursorPosition(true);
}

void moveMouseRel(int dx, int dy) {
    CGEventRef ourEvent = CGEventCreate(NULL);
    CGPoint current = CGEventGetLocation(ourEvent);
    CFRelease(ourEvent);
    moveMouse(current.x + dx, current.y + dy);
}

void smoothMoveMouse(int x, int y) {
    CGEventRef ourEvent = CGEventCreate(NULL);
    CGPoint start = CGEventGetLocation(ourEvent);
    CFRelease(ourEvent);

    const int steps = 30;
    for (int i = 1; i <= steps; ++i) {
        float t = (float)i / steps;
        float nx = start.x + t * (x - start.x);
        float ny = start.y + t * (y - start.y);
        moveMouse(nx, ny);
        usleep(10000);
    }
}

void clickMouse(const char* button) {
    CGMouseButton btn = kCGMouseButtonLeft;
    if (strcmp(button, "right") == 0) btn = kCGMouseButtonRight;
    CGPoint pt = CGEventGetLocation(CGEventCreate(NULL));
    CGEventRef click_down = CGEventCreateMouseEvent(NULL, kCGEventLeftMouseDown, pt, btn);
    CGEventRef click_up = CGEventCreateMouseEvent(NULL, kCGEventLeftMouseUp, pt, btn);
    CGEventPost(kCGHIDEventTap, click_down);
    CGEventPost(kCGHIDEventTap, click_up);
    CFRelease(click_down);
    CFRelease(click_up);
}

void doubleClickMouse() {
    clickMouse();
    usleep(150000);
    clickMouse();
}

void rightClickMouse() {
    clickMouse("right");
}

void mouseDown(const char* button) {
    CGMouseButton btn = kCGMouseButtonLeft;
    if (strcmp(button, "right") == 0) btn = kCGMouseButtonRight;
    CGPoint pt = CGEventGetLocation(CGEventCreate(NULL));
    CGEventRef ev = CGEventCreateMouseEvent(NULL, kCGEventLeftMouseDown, pt, btn);
    CGEventPost(kCGHIDEventTap, ev);
    CFRelease(ev);
}

void mouseUp(const char* button) {
    CGMouseButton btn = kCGMouseButtonLeft;
    if (strcmp(button, "right") == 0) btn = kCGMouseButtonRight;
    CGPoint pt = CGEventGetLocation(CGEventCreate(NULL));
    CGEventRef ev = CGEventCreateMouseEvent(NULL, kCGEventLeftMouseUp, pt, btn);
    CGEventPost(kCGHIDEventTap, ev);
    CFRelease(ev);
}

void dragMouseTo(int x, int y) {
    mouseDown();
    smoothMoveMouse(x, y);
    mouseUp();
}

void scrollMouse(int lines) {
    CGEventRef scroll = CGEventCreateScrollWheelEvent(NULL, kCGScrollEventUnitLine, 1, lines);
    CGEventPost(kCGHIDEventTap, scroll);
    CFRelease(scroll);
}