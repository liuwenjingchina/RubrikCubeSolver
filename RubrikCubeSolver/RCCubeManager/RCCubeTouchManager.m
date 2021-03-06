//
//  RCCubeTouchManager.m
//  RubrikCubeSolver
//
//  Created by 刘文景 on 13-9-1.
//  Copyright (c) 2013年 刘文景. All rights reserved.
//

#import "RCCubeTouchManager.h"
#import "RCCubeService.h"
#import "RCCubeTouchManagerDelegate.h"
@interface RCCubeTouchManager()
{
}
@property(strong, nonatomic)NSMutableArray *Delegates;

@property (strong, nonatomic)NSMutableArray *touchLocations;
@property (strong, nonatomic)NSMutableArray *touchTimes;

-(void)_notifyTouchBegin:(NSSet *)touchs;
-(void)_notifyTouchEnd:(NSSet *)touchs;
-(void)_notifyTouchMoveDistance:(float)distance;

@end
@implementation RCCubeTouchManager
+(id)alloc
{
    RCCubeTouchManager *cubeTouchManager = [super alloc];
    NSMutableArray *touchLocations = [NSMutableArray alloc];
    NSMutableArray *touchTimes = [NSMutableArray alloc];
    RCAssert(cubeTouchManager && touchLocations && touchTimes, @"alloc failure");
    NSMutableArray *delegates = [NSMutableArray alloc];

    cubeTouchManager.touchLocations = touchLocations;
    cubeTouchManager.touchTimes = touchTimes;
    cubeTouchManager.Delegates = delegates;
    return cubeTouchManager;
}

-(id)init
{
    NSMutableArray *touchLocations = [self.touchLocations initWithCapacity:10];
    NSMutableArray *touchTimes = [self.touchTimes initWithCapacity:10];
    NSMutableArray *delegates = [self.Delegates initWithCapacity:10];
    self = [super init];
    RCAssert(self, @"init failure");
    self.touchLocations = touchLocations;
    self.touchTimes = touchTimes;
    self.Delegates = delegates;
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    // Initialization
    self.CubeService.isTouching = YES;
    [_CubeService setCubeRotationSpeed:0];
    [self _notifyTouchBegin:touches];
    [_touchLocations removeAllObjects];
    [_touchTimes removeAllObjects];
    
    // Insert TouchLocation and TouchTime
    double CurrentTime = [[NSDate date] timeIntervalSince1970];
    NSNumber *CurrentTimeNumber = [NSNumber numberWithDouble:CurrentTime];
    UITouch *touch = [touches anyObject];
    float xLocation = [touch locationInView:touch.view].x;
    NSNumber *xLocationNumber = [[NSNumber alloc] initWithDouble:xLocation];
    [_touchLocations insertObject: xLocationNumber atIndex:0];
    [_touchTimes insertObject:CurrentTimeNumber atIndex:0];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Last Location
    NSNumber *lastLocationNumber = [_touchLocations objectAtIndex:0];
    CGFloat lastLocationX = [lastLocationNumber floatValue];
    
    // Insert Current Location
    UITouch *currentTouch = [touches anyObject];
    CGPoint currentLocation = [currentTouch locationInView:currentTouch.view];
    NSNumber *currentLocationNumber = [NSNumber numberWithFloat:currentLocation.x];
    [_touchLocations insertObject:currentLocationNumber atIndex:0];
    
    // Insert Current Time
    double currentTime = [[NSDate date] timeIntervalSince1970];
    NSNumber *currentTimeNumber = [NSNumber numberWithDouble:currentTime];
    [_touchTimes insertObject:currentTimeNumber atIndex:0];
    
    // Location Difference
    CGFloat locationDiff = (currentLocation.x - lastLocationX );
    
    // Notify location difference
    [self _notifyTouchMoveDistance:locationDiff/60];

    // Delete old location and time
    if ([_touchLocations count]>5) [_touchLocations removeLastObject];
    if ([_touchTimes count]>5) [_touchTimes removeLastObject];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Get time
    NSNumber *lastLocationNumber = [_touchLocations lastObject];
    CGFloat lastLocation = [lastLocationNumber floatValue];
    UITouch *currentTouch = [touches anyObject];
    CGPoint currentLocation = [currentTouch locationInView:currentTouch.view];
    
    // Get Location
    NSNumber *lastTimeNumber = [_touchTimes lastObject];
    double CurrentTime = [[NSDate date] timeIntervalSince1970];
    NSNumber *CurrentTimeNumber = [NSNumber numberWithDouble:CurrentTime];
    
    // Calculate Speed
    double startTime, startLocation, endTime, endLocation;
    startTime = [lastTimeNumber doubleValue];
    startLocation = lastLocation;
    endTime = [CurrentTimeNumber doubleValue];
    endLocation = currentLocation.x;
    double speed = (endLocation - startLocation)/(endTime - startTime)/60;
    [_CubeService setCubeRotationSpeed:speed];
    [self _notifyTouchEnd:touches];
    self.CubeService.isTouching = NO;
    
    // Remove touches
    [_touchLocations removeAllObjects];
    [_touchTimes removeAllObjects];
}

-(void)addDelegate:(id)object
{
    [_Delegates addObject:object];
}

-(void)removeDelegate:(id)object
{
    [_Delegates removeObject:object];
}

-(void)_notifyTouchBegin:(NSSet *)touchs
{
    for (id<RCCubeTouchManagerDelegate>delegate in _Delegates) {
        [delegate cubeTouchManager:self NotifyTouchBegin:touchs];
    }
}

-(void)_notifyTouchMoveDistance:(float)distance
{
    for (id<RCCubeTouchManagerDelegate>delegate in _Delegates) {
        [delegate cubeTouchManager:self NotifyTouchMoveDistance:distance];
    }
}

-(void)_notifyTouchEnd:(NSSet *)touchs
{
    for (id<RCCubeTouchManagerDelegate>delegate in _Delegates) {
        [delegate cubeTouchManager:self NotifyTouchEnd:touchs];
    }
}

@end
