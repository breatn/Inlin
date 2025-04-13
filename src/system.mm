#include "../include/system.h"
#import <ApplicationServices/ApplicationServices.h>

void getMousePosition(int& x, int& y) {
    CGEventRef event = CGEventCreate(NULL);
    CGPoint loc = CGEventGetLocation(event);
    x = loc.x;
    y = loc.y;
    CFRelease(event);
}