//
//  RCBlockManager.m
//  RubrikCubeSolver
//
//  Created by 刘文景 on 13-9-1.
//  Copyright (c) 2013年 刘文景. All rights reserved.
//

#import "RCBlockService.h"
#import "RCBlock.h"
#import "RCMove.h"
// private variables and functions
@interface RCBlockService()
{
    RCBlock _blocks [3][3][3];
}
- (void)_setIsSetColorNeeded:(BOOL)needed AtIndex:(RCIndex)index;
@end

// public functions
@implementation RCBlockService
@synthesize currentMove;
+ (id)alloc
{
    RCBlockService *blockManager = [super alloc];
    RCAssert(blockManager, @"alloc failure");
    return blockManager;
}

- (id)init
{
    self = [super init];
    
    // init cube data blocks
    for (int i=0; i<3; i++) {
        for (int j=0; j<3; j++) {
            for (int k=0; k<3; k++) {
                RCIndex index;
                index.i = i;
                index.j = j;
                index.k = k;
                
                // init stillPosition & rotatingPosition
                RCPosition position;
                position.x = k-1;
                position.y = 1-j;
                position.z = 1-i;
                [self setStillPosition:position AtIndex:index];
                [self setRotatingPosition:position AtIndex:index];
                
                // init stillRotation * rotatingRotation
                RCRotation rotation;
                rotation.x = 0;
                rotation.y = 0;
                rotation.z = 0;
                
                // init isSetColorNeeded
                [self _setIsSetColorNeeded:NO AtIndex:index];
            }
        }
    }
    // init isRotating
    self.currentMove = RCMoveStill;
    
    return self;
}

-(void)setStillPosition:(RCPosition)position AtIndex:(RCIndex)index
{
    _blocks[index.i][index.j][index.k].stillPosition = position;
}

-(RCPosition)getStillPositionAtIndex:(RCIndex)index
{
    return _blocks[index.i][index.j][index.k].stillPosition;
}

-(void)setRotatingPosition:(RCPosition)position AtIndex:(RCIndex)index
{
    _blocks[index.i][index.j][index.k].rotatingPosition = position;
}

-(RCPosition)getRotatingPositionAtIndex:(RCIndex)index
{
    return _blocks[index.i][index.j][index.k].rotatingPosition;
}

-(void)setStillRotation:(RCRotation)rotation AtIndex:(RCIndex)index
{
    _blocks[index.i][index.j][index.k].stillRotation = rotation;
}

-(RCRotation)getStillRotationAtIndex:(RCIndex)index
{
    return _blocks[index.i][index.j][index.k].stillRotation;
}

- (BOOL)isRotatingAtIndex:(RCIndex)index
{
    int convertedIndex = index.i*9 + index.j*3 +index.k;
    RCAssert(convertedIndex<31, @"Bad index");
    return [self getBit:[self.currentMove moveType] AtIndex:convertedIndex];
}

-(BOOL)isSetColorNeededAtIndex:(RCIndex)index
{
    return _blocks[index.i][index.j][index.k].isSetColorNeeded;
}

- (void)_setIsSetColorNeeded:(BOOL)needed AtIndex:(RCIndex)index
{
    _blocks[index.i][index.j][index.k].isSetColorNeeded = needed;
}

@end
