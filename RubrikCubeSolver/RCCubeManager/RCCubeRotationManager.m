//
//  RCCubeRotationManager.m
//  RubrikCubeSolver
//
//  Created by 刘文景 on 13-9-1.
//  Copyright (c) 2013年 刘文景. All rights reserved.
//

#import "RCCubeRotationManager.h"
#import "RCCubeService.h"
#import <GLKit/GLKit.h>
@interface RCCubeRotationManager()
{
    BOOL _cubeRotationUpdateNeeded;
    BOOL _moveRotationUpdateNeeded;
    NSTimer *_updateTimer;
    NSDate *_startTime;
    NSDate *_endTime;
}
-(void)_update;
@end

@implementation RCCubeRotationManager
+(id)alloc
{
    RCCubeRotationManager *cubeRotationManager = [super alloc];
    RCAssert(cubeRotationManager, @"alloc failure");
    return cubeRotationManager;
}

-(id)init
{
    self = [super init];
    RCAssert(self, @"init failure");
    return self;
}

-(void)cubeService:(RCCubeService *)cubeService NotifyChange:(RCCubeServiceChange)change
{
    BOOL visibility = [cubeService visibility];
    // Need to update flags
    if (visibility) {
        _cubeRotationUpdateNeeded = [cubeService cubeRotationSpeed]==0? NO:YES;
        _moveRotationUpdateNeeded = self.currentMove==RCMoveStill? NO:YES;
    }else {
        _cubeRotationUpdateNeeded = NO;
        _moveRotationUpdateNeeded = NO;
    }
    
    // If anything needs to be updated frequently, register a timer
    if (_cubeRotationUpdateNeeded||_moveRotationUpdateNeeded) {
         _updateTimer = [NSTimer timerWithTimeInterval:1/DATA_REFRESH_RATE target:self selector:@selector(_update) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_updateTimer forMode:NSDefaultRunLoopMode];
    }else {
        if (_updateTimer) {
            [_updateTimer invalidate];
        }
    }
}

- (void)_update
{
    _startTime = _endTime;
    _endTime = [NSDate date];
    if (!_startTime) return; // if cannot calculate time diff
    
    // Calculate Time difference
    NSTimeInterval timeDiff = [_endTime timeIntervalSinceDate:_startTime];
    
    // Update CubeRotation
    RCRotation newRotation = _CubeService.cubeRotation;
    newRotation.y += timeDiff;
    _CubeService.cubeRotation = newRotation;
    
    // Update flag
    self.hasUpdate = YES;
}
@end