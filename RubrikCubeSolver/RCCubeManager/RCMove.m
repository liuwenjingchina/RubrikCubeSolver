//
//  RCMove.m
//  RubrikCubeSolver
//
//  Created by 刘文景 on 13-9-7.
//  Copyright (c) 2013年 刘文景. All rights reserved.
//

#import "RCMove.h"
@interface RCMove()
-(NSInteger)_getID;
@end

@implementation RCMove
@synthesize moveType,moveID,completeness;

+(id)moveWithType:(RCMoveDescriptor)moveType1
{
    RCMove *move = [[RCMove alloc] initWithType:(RCMoveDescriptor)moveType1];
    RCAssert(move, @"alloc failure");
    return move;
}

-(id)initWithType:(RCMoveDescriptor)moveType1
{
    self = [super init];
    RCAssert(self, @"init failure");
    self.moveID = [self _getID];
    self.moveType = moveType1;
    return self;
}

-(NSInteger)_getID
{
    static NSInteger currentID;
    return currentID++;
}

-(RCStillRotation)rotation
{
    RCStillRotation rotation;
    int clockwise = [self getBit:self.moveType AtIndex:31];
    if (clockwise != 1) clockwise = -1;
    switch (self.moveType) {
        case RCMoveStill:
            rotation = [self makeRotationX:0 Y:0 Z:0];
            break;
        case RCMoveL:case RCMoveLP:case RCMoveR:case RCMoveRP:
            rotation = [self makeRotationX:clockwise Y:0 Z:0];
            break;
        case RCMoveU:case RCMoveUP:case RCMoveD:case RCMoveDP:
            rotation = [self makeRotationX:0 Y:clockwise Z:0];
            break;
        case RCMoveF:case RCMoveFP:case RCMoveB:case RCMoveBP:
            rotation = [self makeRotationX:0 Y:0 Z:clockwise];
            break;
        default:
            RCAssert(0, @"No such move type %d",self.moveType);
            break;
    }
    return rotation;
}
@end
