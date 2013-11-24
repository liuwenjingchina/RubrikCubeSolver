//
//  RCCube.h
//  RubrikCubeSolver
//
//  Created by 刘文景 on 13-9-1.
//  Copyright (c) 2013年 刘文景. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCBaseClass.h"
#import "RCBlock.h"
#import "RCMove.h"

@class RCBlockService,
RCCubeMoveManager,
RCCubeRotationManager,
RCCubeDrawManager;


/*
 * RCCubeService
 * Maintains state of the cube
 */
@interface RCCubeService : RCBaseClass
@property RCPosition cubePosition;
@property RCRotation cubeRotation;
@property(weak, atomic)RCMove *currentMove;
@property(strong, atomic)RCBlockService *blockService;
@property BOOL isTouching;
@property BOOL visibility;
@property NSInteger pendingMoves;

-(void)setCubeRotationSpeed:(RCSpeed)cubeRotationSpeed;
-(RCSpeed)cubeRotationSpeed;
-(void)addDelegate:(id)object;
-(void)removeDelegate:(id)object;
-(void)notifyCubeWillDraw;
-(void)notifyCubeDidDraw;
-(void)notifyCubeDidFinishCurrentMove;
-(void)notifyCubeStartNewMove;
@end
