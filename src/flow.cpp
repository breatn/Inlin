#include "../include/flow.h"
#include "../include/screen.h"
#include <chrono>
#include <thread>

void waitUntilPixelColor(int x, int y, unsigned int color, int timeoutMs) {
    auto start = std::chrono::steady_clock::now();

    while (true) {
        int r, g, b;
        getPixelColor(x, y, r, g, b);
        // Combine the RGB values into a single unsigned int (assumes r in highest 8 bits, then g, then b)
        unsigned int currentColor = (r << 16) | (g << 8) | b;

        if (currentColor == color) {
            break;
        }

        // Check for timeout
        auto now = std::chrono::steady_clock::now();
        auto elapsed = std::chrono::duration_cast<std::chrono::milliseconds>(now - start).count();
        if (elapsed >= timeoutMs) {
            break;
        }

        // Sleep for a short duration before checking again
        std::this_thread::sleep_for(std::chrono::milliseconds(10));
    }
}

void sleepMs(int ms) {
    std::this_thread::sleep_for(std::chrono::milliseconds(ms));
}
