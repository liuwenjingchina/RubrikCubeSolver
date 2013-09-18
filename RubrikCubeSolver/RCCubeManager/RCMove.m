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

-(RCRotation)rotation
{
    RCRotation rotation;
    switch (self.moveType) {
        case RCMoveStill:
            rotation = [self makeRotationX:0 Y:0 Z:0];
            break;
        case RCMoveL:
            rotation = [self makeRotationX:-1 Y:0 Z:0];
            break;
        default:
            RCAssert(0, @"No such move type %d",self.moveType);
            break;
    }
    return rotation;
}
@end
