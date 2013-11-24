//
//  RCBlockManager.h
//  RubrikCubeSolver
//
//  Created by 刘文景 on 13-9-1.
//  Copyright (c) 2013年 刘文景. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCBaseClass.h"

@class RCMove;
@interface RCBlockService : RCBaseClass
@property (strong, atomic) RCMove *currentMove;

- (void)setStillPosition:(RCPosition) position AtIndex:(RCIndex) index;
- (RCPosition)getStillPositionAtIndex:(RCIndex)index;
- (void)setStillRotation:(GLKMatrix4) rotation AtIndex:(RCIndex) index;
- (GLKMatrix4)getStillRotationAtIndex:(RCIndex)index;

- (BOOL)isRotatingAtIndex:(RCIndex)index;
- (BOOL)isSetColorNeededAtIndex:(RCIndex)index;

- (void)computeCurrentMove;
@end
