#define RCAssert(condition, fmt, ...) NSAssert(condition, (@"%s [Line %d] AssertionFailure: " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#ifdef DEBUG
#   define RCLog(fmt, ...) NSLog((@"%s " fmt), __PRETTY_FUNCTION__, ##__VA_ARGS__)
#else
#   define RCLog(...)
#endif