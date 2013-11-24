//
//  RCCubeRotationManager.m
//  RubrikCubeSolver
//
//  Created by 刘文景 on 13-9-1.
//  Copyright (c) 2013年 刘文景. All rights reserved.
//

#import "RCCubeRotationManager.h"
#import "RCCubeService.h"
#import "RCMove.h"
#import <GLKit/GLKit.h>
#import "RCCubeMoveManager.h"
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
-(RCSpeed)_add:(RCSpeed)speed1 with:(RCSpeed)speed2;
-(void)updateCubeLevelRotation;
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

- (void)cubeServiceWillDraw:(RCCubeService *)cubeService
{
    [self updateCubeLevelRotation];
}

-(void)updateCubeLevelRotation
{
    if (!_startTime) {
        /* If it is the first time coming into update, we will not do anything, since update needs to calculate the time difference between last update the this update, we donot have last time value.
         */
        // Record the time it entered.
        _startTime = [NSDate date];
        return;
    }
    
    
    /****************************** Updating current cube level rotation *****************************/
    // Calculate time difference
    _endTime = [NSDate date];
    NSTimeInterval timeDiff = [_endTime timeIntervalSinceDate:_startTime];
    _startTime = _endTime;
    
    // Get current rotation
    RCRotation curRotation, newRotation;
    curRotation = [_CubeService cubeRotation];
    newRotation.x = 0;
    newRotation.z = 0;
    // Update rotation
    if (!self.CubeService.isTouching) {
        // Calculate rotation based on speed if no touching screen
        RCSpeed curSpeed;
        curSpeed = [_CubeService cubeRotationSpeed];
        
        // update speed
        if (abs(curSpeed)>1) {
            // Need to speed down
            curSpeed = [self _add:curSpeed*0.97 with:0];
            if (abs(curSpeed)<1) {
                if(curSpeed >= 0){
                    // Make speed standard
                    curSpeed = 1;
                } else if(curSpeed < 0){
                    curSpeed = -1;
                }
            }
        }
        
        [_CubeService setCubeRotationSpeed:[self _add:curSpeed with:0]];
        
        // Calculate rotation
        /* have a constant factor to made the speed compatible with touchMoveDistance */
        float constantFactor = 0.5f;
        float distanceDiff = [self _add:timeDiff*curSpeed*constantFactor with:0];
        newRotation.y = [self _add:curRotation.y with:distanceDiff];
        
    } else{
        // Calculate rotation based on touch moving distance
        newRotation.y = [self _add:curRotation.y with:_touchMoveDistance];
        _touchMoveDistance = 0;
    }
    
    // Update the cube rotation based on the calculation above
    [_CubeService setCubeRotation:newRotation];
    
    
    
    
    
    /************************************ Updating move completeness *********************************/
    // If have current move update
    if ([self.CubeService currentMove]) {
        // Update completeness
        self.CubeService.currentMove.completeness += 0.05;
        
        if (self.CubeService.currentMove.completeness>=1) {
            // If has completed end the move
            [self.CubeService notifyCubeDidFinishCurrentMove];
            //[_CubeMoveManager endMove:_currentMove];
        }
    }
    
    // If not have current move start new move
    else if(self.CubeService.pendingMoves){
        [self.CubeService notifyCubeStartNewMove];
    }

}

- (void)cubeTouchManager:(RCCubeTouchManager *)cubeTouchManager NotifyTouchBegin:(NSSet *)touchs
{
    /* If is touching we will call update based on touch move notification 
     instead of using time to update.
     */
    _touchMoveDistance = 0;
}

- (void)cubeTouchManager:(RCCubeTouchManager *)cubeTouchManager NotifyTouchEnd:(NSSet *)touchs
{
    /* If not touch anymore we should judge whether we need to register a timer update now.
     */
    _touchMoveDistance = 0;
}

-(void)cubeTouchManager:(RCCubeTouchManager *)cubeTouchManager NotifyTouchMoveDistance:(float)distance
{
    /* update touch move distance
     * and call update directly
     */
    _touchMoveDistance += distance;
    //[self _update];
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