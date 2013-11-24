#define RCAssert(condition, fmt, ...) NSAssert(condition, (@"%s [Line %d] AssertionFailure: " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);


#ifdef DEBUG
#   define NSLog(FORMAT, ...) fprintf(stderr,"%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#   define RCLog(fmt, ...) NSLog((@"%s " fmt), __PRETTY_FUNCTION__, ##__VA_ARGS__)
#else
#   define RCLog(...)
#   define NSLog(...)
#endif