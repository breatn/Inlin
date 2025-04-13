cmake_minimum_required(VERSION 3.10)

project(inlin)

# Specify the C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Add the source files
set(SOURCES
    src/mouse.mm
    src/keyboard.mm
    src/screen.mm
    src/flow.cpp
    src/system.mm
    src/inlin_api.cpp
    main.cpp
)

# Include the header directory so we can use #include "inlin_api.h"
include_directories(${PROJECT_SOURCE_DIR}/include)

# Force pybind11 to use the modern FindPython
set(PYBIND11_FINDPYTHON ON)

# Find pybind11
find_package(pybind11 REQUIRED)

# Automatically find Python3 components
find_package(Python3 COMPONENTS Interpreter Development REQUIRED)

# Create the target for the executable
add_executable(inlin ${SOURCES})

# Link the target with pybind11 and Python3, plus macOS frameworks
target_link_libraries(inlin PRIVATE pybind11::embed Python3::Python)
target_link_libraries(inlin PRIVATE
    "-framework ApplicationServices"
    "-framework Cocoa"
)
