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
    BOOL _isTouching;
    NSTimer *_updateTimer;
    NSDate *_startTime;
    NSDate *_endTime;
    float _touchMoveDistance;
}
-(void)_update;
-(RCSpeed)_add:(RCSpeed)speed1 with:(RCSpeed)speed2;
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
    _isTouching = NO;
    RCAssert(self, @"init failure");
    return self;
}

/*
 @brief
 Determine what it should do during update
 */
/*
-(void)cubeService:(RCCubeService *)cubeService NotifyChange:(RCCubeServiceChange)change
{
    BOOL visibility = [cubeService visibility];

    // If visible
    if (visibility) {
        // and is doing rotation
        _cubeRotationUpdateNeeded = [cubeService cubeRotationSpeed]==0? NO:YES;
        
        // and is committing a move
        _moveRotationUpdateNeeded = self.currentMove==RCMoveStill? NO:YES;
    }else {
    // Not visible no need to update anything
        _cubeRotationUpdateNeeded = NO;
        _moveRotationUpdateNeeded = NO;
    }
    
    // If anything needs to be updated frequently, register a timer
    if (_cubeRotationUpdateNeeded||_moveRotationUpdateNeeded||!_isTouching) {
        if (!_updateTimer || !_updateTimer.isValid) {
            
            RCLog(@"Register update timer");
            _updateTimer = [NSTimer timerWithTimeInterval:1/60.0f target:self selector:@selector(_update) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:_updateTimer forMode:NSDefaultRunLoopMode];
            _startTime = NULL;
            _endTime = NULL;
        }
    }else {
        if (_updateTimer) {
            RCLog(@"Unregister update timer");
            [_updateTimer invalidate];
            _updateTimer = NULL;
            _startTime = NULL;
            _endTime = NULL;
        }
    }
}
*/
- (void)cubeServiceWillDraw:(RCCubeService *)cubeService
{
    // Check if it is the first time coming
    if (!_startTime) {
        /* If it is the first time coming into update, we will not do anything, since update needs to calculate the time difference between last update the this update, we donot have last time value.
         */
        // Record the time it entered.
        RCLog(@"First Time Enter");
        _startTime = [NSDate date];
        return;
    }

    // Record current time & calculate time difference for speed caliberation
    _endTime = [NSDate date];

    NSTimeInterval timeDiff = [_endTime timeIntervalSinceDate:_startTime];
    //RCLog(@"timeDiff: %.4f",timeDiff);
    
    // Get current rotation
    RCRotation curRotation, newRotation;
    curRotation = [_CubeService cubeRotation];
    
    // Save the current time value for caliberation of next time
    _startTime = _endTime;
    
    // Update rotation
    if (!_isTouching) {
        // Calculate rotation based on calerbrated speed if no touching screen
        RCSpeed curSpeed,calibratedSpeed;
        curSpeed = [_CubeService cubeRotationSpeed];
        calibratedSpeed = 0;
        
        /*
         @todo Define stdTimeInterval somewhere
         */
        // Calculate caliberation factor - time Factor
        float stdTimeInterval = 1/FRAME_REFRESH_RATE;
        float timeFactor = timeDiff/stdTimeInterval;

        /*
         @todo Make speed defined somewhere
         */
        
        // update speed without caliberation 
        if (abs(curSpeed)>1) {
            // Need to speed down
            curSpeed = [self _add:curSpeed*0.97 with:0] ;
        }
        if(abs(curSpeed)<1&&curSpeed>=0){
            // Make speed standard
            curSpeed = 1;
        } else if(abs(curSpeed)<1&&curSpeed<0){
            curSpeed = -1;
        }
        [_CubeService setCubeRotationSpeed:[self _add:curSpeed with:0]];
        
        // Calculate speed after calibration
        calibratedSpeed = [self _add:curSpeed*timeFactor with:0];
        
        // Calculate rotation
        /* have a constant factor to made the speed compatible with touchMoveDistance */
        float constantFactor = 1.5;
        float distanceDiff = [self _add:stdTimeInterval*calibratedSpeed*constantFactor with:0];
        newRotation.y = [self _add:curRotation.y with:distanceDiff];
        
        //RCLog(@"Distance Diff: %.2f", distanceDiff);
    } else{
        // Calculate rotation based on touch moving distance
        newRotation.y = [self _add:curRotation.y with:_touchMoveDistance];
        _touchMoveDistance = 0;
        //RCLog(@"Distance Diff: %.2f", _touchMoveDistance);
    }
    
    // Update the cube rotation based on the calculation above
    [_CubeService setCubeRotation:newRotation];
}

- (void)cubeTouchManager:(RCCubeTouchManager *)cubeTouchManager NotifyTouchBegin:(NSSet *)touchs
{
    /* If is touching we will call update based on touch move notification 
     instead of using time to update.
     */
    _isTouching = YES;
}

- (void)cubeTouchManager:(RCCubeTouchManager *)cubeTouchManager NotifyTouchEnd:(NSSet *)touchs
{
    /* If not touch anymore we should judge whether we need to register a timer update now.
     */
    _isTouching = NO;
}

-(void)cubeTouchManager:(RCCubeTouchManager *)cubeTouchManager NotifyTouchMoveDistance:(float)distance
{
    /* update touch move distance
     * and call update directly
     */
    _touchMoveDistance += distance;
}

-(RCSpeed)_add:(RCSpeed)speed1 with:(RCSpeed)speed2
{
    RCSpeed newSpeed = speed1+speed2;
    while (abs(newSpeed)>180){
        if (newSpeed>0) {
            newSpeed -= 360;
        } else{
            newSpeed += 360;
        }
    }
    return newSpeed;
}

@end