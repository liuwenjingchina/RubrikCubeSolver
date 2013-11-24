//
//  RCBlockManager.h
//  RubrikCubeSolver
//
//  Created by 刘文景 on 13-9-1.
//  Copyright (c) 2013年 刘文景. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCBlock.h"
@class RCMove;
@interface RCBlockService : NSObject
@property (strong, atomic) RCMove *currentMove;

- (void)setStillPosition:(RCPosition) position AtIndex:(RCIndex) index;
- (RCPosition)getStillPositionAtIndex:(RCIndex)index;
- (void)setRotatingPosition:(RCPosition) position AtIndex:(RCIndex) index;
- (RCPosition)getRotatingPositionAtIndex:(RCIndex)index;
- (void)setStillRotation:(RCRotation) rotation AtIndex:(RCIndex) index;
- (RCRotation)getStillRotationAtIndex:(RCIndex)index;
- (RCBlock)getBlockAtIndex:(RCIndex)index;
- (void)setBlock:(RCBlock)block AtIndex:(RCIndex)index;

- (BOOL)isRotatingAtIndex:(RCIndex)index;
- (BOOL)isSetColorNeededAtIndex:(RCIndex)index;
@end
