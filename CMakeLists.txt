cmake_minimum_required(VERSION 3.10)

project(macos_autogui)

# Specify the C++ standard (optional, recommended)
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

# Include the header directory so that we can use #include "inlin_api.h"
include_directories(${PROJECT_SOURCE_DIR}/include)

# Create the target for the executable
add_executable(inlin ${SOURCES})

# Find pybind11
find_package(pybind11 REQUIRED)

# Link pybind11 and macOS-specific frameworks after creating the target
target_link_libraries(inlin PRIVATE
    pybind11::embed
    "-framework ApplicationServices"
    "-framework Cocoa"
)