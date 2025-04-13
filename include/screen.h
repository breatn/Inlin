#ifndef SCREEN_H
#define SCREEN_H

#include <string>

void screenshot(const std::string &filename);
void getPixelColor(int x, int y, int &r, int &g, int &b);
void regionScreenshot(const char* filename, int x, int y, int width, int height);
void getScreenSize(int &width, int &height);

#endif