#import <ApplicationServices/ApplicationServices.h>
#include <unistd.h>  // for usleep

// Simple implementations for demonstration purposes.
// In a real-world scenario, map key strings to appropriate CGKeyCode values.
void pressKey(const char* key) {
    // Convert the key (assumed single character) to UniChar.
    UniChar uc = key[0];
    // Create a key down event.
    CGEventRef keyDown = CGEventCreateKeyboardEvent(NULL, 0, true);
    CGEventKeyboardSetUnicodeString(keyDown, 1, &uc);
    CGEventPost(kCGHIDEventTap, keyDown);
    CFRelease(keyDown);
}

void releaseKey(const char* key) {
    UniChar uc = key[0];
    // Create a key up event.
    CGEventRef keyUp = CGEventCreateKeyboardEvent(NULL, 0, false);
    CGEventKeyboardSetUnicodeString(keyUp, 1, &uc);
    CGEventPost(kCGHIDEventTap, keyUp);
    CFRelease(keyUp);
}

void hotkey(const char* key1, const char* key2) {
    // Press both keys.
    pressKey(key1);
    pressKey(key2);
    // Small delay, adjust as needed.
    usleep(10000); // 10ms delay
    // Release keys in reverse order.
    releaseKey(key2);
    releaseKey(key1);
}

// Existing autoTypeText remains unchanged.
void autoTypeText(const char* text) {
    for (int i = 0; text[i] != '\0'; i++) {
        UniChar uc = static_cast<UniChar>(text[i]);
        CGEventRef keyDown = CGEventCreateKeyboardEvent(NULL, 0, true);
        CGEventKeyboardSetUnicodeString(keyDown, 1, &uc);
        CGEventRef keyUp = CGEventCreateKeyboardEvent(NULL, 0, false);
        CGEventKeyboardSetUnicodeString(keyUp, 1, &uc);
        CGEventPost(kCGHIDEventTap, keyDown);
        CGEventPost(kCGHIDEventTap, keyUp);
        CFRelease(keyDown);
        CFRelease(keyUp);
    }
}