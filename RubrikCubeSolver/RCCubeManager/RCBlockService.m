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
    RCBlock _blocks [27];
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
                
                // init stillRotation * rotatingRotation
                GLKMatrix4 rotation = GLKMatrix4MakeTranslation(0, 0, 0);
                [self setStillRotation:rotation AtIndex:index];
                
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
    _blocks[index.i*9+index.j*3+index.k].stillPosition = position;
}

-(RCPosition)getStillPositionAtIndex:(RCIndex)index
{
    return _blocks[index.i*9+index.j*3+index.k].stillPosition;
}


-(void)setStillRotation:(GLKMatrix4)rotation AtIndex:(RCIndex)index
{
    _blocks[index.i*9+index.j*3+index.k].stillRotation = rotation;
}

-(GLKMatrix4)getStillRotationAtIndex:(RCIndex)index
{
    return _blocks[index.i*9+index.j*3+index.k].stillRotation;
}

- (BOOL)isRotatingAtIndex:(RCIndex)index
{
    int convertedIndex = index.i*9 + index.j*3 +index.k;
    RCAssert(convertedIndex<31, @"Bad index");
    return [self getBit:[self.currentMove moveType] AtIndex:convertedIndex];
}

-(BOOL)isSetColorNeededAtIndex:(RCIndex)index
{
    //return _blocks[index.i][index.j][index.k].isSetColorNeeded;
    return false;
}

- (void)_setIsSetColorNeeded:(BOOL)needed AtIndex:(RCIndex)index
{
    //_blocks[index.i][index.j][index.k].isSetColorNeeded = needed;
}

-(void)computeCurrentMove
{
    /**************************** Back up blocks & Compute Move Rotation ***************************/
    RCBlock backupBlock [9];
    int count = 0;
    for (int i=0; i<27; i++) {
        // Back up block
        if([self getBit:[self.currentMove moveType] AtIndex:i]){
            // Compute move rotation
            GLKMatrix4 currentRotation = GLKMatrix4MakeRotation(GLKMathDegreesToRadians(90), currentMove.rotation.x, currentMove.rotation.y, currentMove.rotation.z);
            _blocks[i].stillRotation = GLKMatrix4Multiply(currentRotation, _blocks[i].stillRotation);
            backupBlock[count++] = (_blocks[i]);
        }
    }
    
    /**************************** Update Rotation *******************************/
    count = 0;
    for (int i=0; i<27; i++) {
        // Back up block
        if([self getBit:[self.currentMove moveType] AtIndex:i]){
            int temp;
            if ([self getBit:currentMove.moveType AtIndex:30]) {
                temp = (6-count*3);
                while (temp < 0 )temp+=10;
            }
            else {
                temp = (2+count*3);
                while (temp > 8) temp-=10;
                
            }
            
            _blocks[i].stillRotation = backupBlock[temp].stillRotation;
            count ++;
        }
    }
}
@end
