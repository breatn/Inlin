#import <Cocoa/Cocoa.h>
#import <ApplicationServices/ApplicationServices.h>
#if defined(__MACOS_X_VERSION_MAX_ALLOWED) && (__MACOS_X_VERSION_MAX_ALLOWED >= 150000)
    // Optionally, include ScreenCaptureKit headers if and when you implement it
    // #import <ScreenCaptureKit/ScreenCaptureKit.h>
#endif

#include <string>  // For std::string

// getPixelColor: Use the old API if building for older OS; otherwise stub out the functionality.
void getPixelColor(int x, int y, int &r, int &g, int &b) {
#if defined(__MACOS_X_VERSION_MAX_ALLOWED) && (__MACOS_X_VERSION_MAX_ALLOWED < 150000)
    // For macOS versions older than 15.0, use the old API.
    CGRect rect = CGRectMake(x, y, 1, 1);
    CGImageRef image = CGWindowListCreateImage(rect, kCGWindowListOptionOnScreenOnly, kCGNullWindowID, kCGWindowImageDefault);
    if (!image) {
        r = g = b = 0;
        return;
    }
    
    CFDataRef data = CGDataProviderCopyData(CGImageGetDataProvider(image));
    const UInt8* pixelData = CFDataGetBytePtr(data);
    
    // Note: This assumes an ARGB format (32bpp)
    r = pixelData[1];
    g = pixelData[2];
    b = pixelData[3];
    
    CFRelease(data);
    CGImageRelease(image);
#else
    // For macOS 15.0 and later, CGWindowListCreateImage is unavailable.
    // TODO: Implement using ScreenCaptureKit. For now, set default values.
    r = g = b = 0;
#endif
}

// getScreenSize remains unchanged.
void getScreenSize(int &width, int &height) {
    NSScreen *screen = [NSScreen mainScreen];
    NSRect frame = [screen frame];
    width = (int)frame.size.width;
    height = (int)frame.size.height;
}

// Update screenshot so that both header and implementation use std::string.
// (Update the declaration in include/screen.h accordingly.)
void screenshot(const std::string &filename) {
    // Stub – you can later implement this function using Quartz Display Services 
    // or ScreenCaptureKit.
}