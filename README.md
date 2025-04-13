# Inlin
MacOS automation software

Inlin is a macOS automation library that uses C++ with embedded Python via Pybind11. It provides functions for performing mouse automation, keyboard automation, screen operations, and flow control. The software exposes these capabilities through the Python module `macos_autogui`.

## Features

- **Mouse Automation**: Move the mouse, simulate clicks (including double and right clicks), drag, and scroll.
- **Keyboard Automation**: Simulate key presses, key releases, hotkeys, and automatically type text.
- **Screen Operations**: Capture screenshots, get pixel colors, and retrieve screen dimensions.
- **Flow Control**: Pause execution and wait until a specific screen pixel matches a given color.

## Requirements

- macOS
- C++ Compiler with C++17 support
- CMake (version 3.10 or later)
- Pybind11 (installed via Homebrew or sourced [pybind11 GitHub](https://github.com/pybind/pybind11))
- Python 3 (tested with Python 3.12)

## Compilation Instructions

Open your terminal in the project directory and run the following commands:

```bash
rm -rf build
mkdir build && cd build
cmake ..
make
```

This will generate the executable `inlin` in the `build` directory.

## Running the Software

The executable expects a Python script filename as a command-line argument. For example:

```bash
./inlin my_script.py
```

In your Python script, you can import the module and call its functions:

```python
import inlin as inl

# Get the screen size
width, height = inl.getScreenSize()
print(f"Screen size: {width}x{height}")

# Move mouse, click and type text
inl.moveMouse(200, 200)
inl.clickMouse()
inl.autoTypeText("Hello from Python!")
```

## Project Structure

```
Inlin/
├── CMakeLists.txt
├── include/
│   ├── inlin_api.h
│   ├── keyboard.h
│   ├── mouse.h
│   ├── screen.h
│   ├── flow.h
│   └── system.h
├── src/
│   ├── inlin_api.cpp
│   ├── keyboard.mm
│   ├── mouse.mm
│   ├── screen.mm
│   ├── flow.cpp
│   └── system.mm
└── main.cpp
```

## License

This project is provided as-is without any warranty.
