#include "inlin_api.h"
#include "../include/mouse.h"
#include "../include/keyboard.h"
#include "../include/screen.h"
#include "../include/flow.h"
#include "../include/system.h"

#include <pybind11/embed.h>    // Must include this to use PYBIND11_EMBEDDED_MODULE
#include <pybind11/stl.h>       // For returning tuples
namespace py = pybind11;

PYBIND11_EMBEDDED_MODULE(inlin, m) {
    // Mouse functions
    m.def("moveMouse", &moveMouse, "Move the mouse to absolute coordinates (x, y).");
    m.def("moveMouseRel", &moveMouseRel, "Move the mouse relative to its current position (dx, dy).");
    m.def("smoothMoveMouse", &smoothMoveMouse, "Smoothly move the mouse to absolute coordinates (x, y).");
    // Wrap clickMouse so it can be called without any arguments
    m.def("clickMouse", []() { clickMouse(""); }, "Simulate a mouse click.");
    m.def("doubleClickMouse", &doubleClickMouse, "Simulate a double mouse click.");
    m.def("rightClickMouse", &rightClickMouse, "Simulate a right mouse click.");
    m.def("mouseDown", &mouseDown, "Simulate pressing the mouse button.");
    m.def("mouseUp", &mouseUp, "Simulate releasing the mouse button.");
    m.def("dragMouseTo", &dragMouseTo, "Drag the mouse to absolute coordinates (x, y).");
    m.def("scrollMouse", &scrollMouse, "Scroll the mouse wheel by a given amount.");

    // Keyboard functions
    m.def("autoTypeText", &autoTypeText, "Type a string of text.");
    m.def("pressKey", &pressKey, "Simulate pressing a key.");
    m.def("releaseKey", &releaseKey, "Simulate releasing a key.");
    m.def("hotkey", &hotkey, "Simulate pressing a combination of keys.");

    // Utility functions
    m.def("sleepMs", &sleepMs, "Pause execution for a given number of milliseconds.");
    m.def("waitUntilPixelColor", &waitUntilPixelColor, "Wait until a pixel at (x, y) matches the given color.");

    // System functions
    m.def("getMousePosition", []() {
        int x, y;
        getMousePosition(x, y);
        return py::make_tuple(x, y);
    }, "Get the current mouse position as a tuple (x, y).");

    m.def("getScreenSize", []() {
        int w, h;
        getScreenSize(w, h);
        return py::make_tuple(w, h);
    }, "Get the screen size as a tuple (width, height).");
} 