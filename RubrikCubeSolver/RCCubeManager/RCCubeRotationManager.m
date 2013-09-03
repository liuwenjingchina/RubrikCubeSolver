//
//  RCCubeRotationManager.m
//  RubrikCubeSolver
//
//  Created by 刘文景 on 13-9-1.
//  Copyright (c) 2013年 刘文景. All rights reserved.
//

#import "RCCubeRotationManager.h"
#import "RCCubeService.h"
@interface RCCubeRotationManager()
{
    BOOL _cubeRotationUpdateNeeded;
    BOOL _moveRotationUpdateNeeded;
    NSTimer *_updateTimer;
}
-(void)_updateRotation;
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

-(void)cubeService:(RCCubeService *)cubeService DidChangedVisibility:(BOOL)visibility
{
    // Need to update flags
    if (visibility) {
        _cubeRotationUpdateNeeded = [cubeService cubeRotationSpeed]==0? NO:YES;
        _moveRotationUpdateNeeded = self.currentMove==RCMoveStill? NO:YES;
    }else {
        _cubeRotationUpdateNeeded = NO;
        _moveRotationUpdateNeeded = NO;
    }
    
    // If anything needs to be updated frequently, register a timer
    if (_cubeRotationUpdateNeeded||_cubeRotationUpdateNeeded) {
         _updateTimer = [NSTimer timerWithTimeInterval:DATA_REFRESH_RATE target:self selector:@selector(_updateRotation) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_updateTimer forMode:NSDefaultRunLoopMode];
    }else {
        if (_updateTimer) {
            [_updateTimer invalidate];
        }
    }
}

- (void)_updateRotation
{
    RCLog(@"entering");
}
@end