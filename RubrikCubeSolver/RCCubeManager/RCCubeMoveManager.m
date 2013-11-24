//
//  RCCubeMoveManager.m
//  RubrikCubeSolver
//
//  Created by 刘文景 on 13-9-1.
//  Copyright (c) 2013年 刘文景. All rights reserved.
//

#import "RCCubeMoveManager.h"
#import "RCCubeRotationManager.h"
#import "RCCubeService.h"
#import "RCBlockService.h"
#import "RCMove.h"
#import "NSObject+RCUtils.h"
#import <GLKit/GLKit.h>

@interface RCCubeMoveManager()
@property (strong, atomic)NSMutableArray *moves;
-(RCMove *) _queueOutMove;
-(void)_completeMove:(RCMove *)move;
@end
@implementation RCCubeMoveManager
+(id)alloc
{
    RCCubeMoveManager *cubeMoveManager = [super alloc];
    RCCubeRotationManager *cubeRotationManager = [RCCubeRotationManager alloc];
    NSMutableArray *moves = [NSMutableArray alloc];
    RCAssert(cubeMoveManager&&cubeMoveManager&&moves, @"alloc failure");
    cubeMoveManager.cubeRotationManager = cubeRotationManager;
    cubeMoveManager.moves = moves;
    return cubeMoveManager;
}

-(id)init
{
    RCCubeRotationManager *cubeRotationManager = [self.cubeRotationManager init];
    NSMutableArray *moves = [self.moves initWithCapacity:10];
    self = [super init];
    RCAssert(self, @"init failure");
    self.cubeRotationManager = cubeRotationManager;
    self.moves = moves;
    return self;
}

-(RCMove *)currentMove
{
    return [self.BlockService currentMove];
}

-(void)queueInMove:(RCMoveDescriptor)moveType
{
    RCMove *move = [RCMove moveWithType:moveType];
    [self.moves insertObject:move atIndex:0];
}

-(RCMove *)_queueOutMove
{
    RCMove *move = [self.moves lastObject];
    if ([self.moves count]!=0) [self.moves removeLastObject];
    return move;
}
-(void)cubeServiceWillStartMove:(RCCubeService *)cubeService
{
    if(!self.BlockService.currentMove) [self newMove];
}

-(RCMove *)newMove
{
    // Get a new Move
    RCMove *newMove = [self _queueOutMove];
    
    // Update currentMove
    [self.BlockService setCurrentMove:newMove];
    
    return newMove;
}

-(void)cubeServiceDidFinishCurrentMove:(RCCubeService *)cubeService
{
    [self endMove:self.BlockService.currentMove];
    self.BlockService.currentMove = nil;
}

-(void)endMove:(RCMove *)endMove
{
    [self.BlockService setCurrentMove:nil];
    // Complete Actual Block Rotation
    [self _completeMove:endMove];
}

-(void)setCurrentMove:(RCMove *)currentMove
{
    [self.BlockService setCurrentMove:currentMove];
}

-(void)_completeMove:(RCMove *)move
{
    RCBlock oldMovingBLocks[9];
    int count = 0;

    // Pick out the cube we want to change
    int i, j ,k;
    for (i=0; i<3; i++) {
        for (j=0; j<3; j++) {
            for (k=0; k<3; k++) {
                if ([self getBit:move.moveType AtIndex:i*9+j*3+k]) {
                    RCIndex index = [self makeIndexI:i J:j K:k];
                    oldMovingBLocks[count] = [self.BlockService getBlockAtIndex:index];
                    count++;
                }
            }
        }
    }
    
    // Apply rotation on block level
    /*
    RCRotation rotation = move.rotation;
    for (i=0; i<count; i++) {
        RCRotation oldRotation = oldMovingBLocks[i].stillRotation;
        oldMovingBLocks[i].stillRotation = GLKMatrix4Multiply(rotation, oldRotation);
    }
    */
}

@end
