//
//  RCBlockManager.h
//  RubrikCubeSolver
//
//  Created by 刘文景 on 13-9-1.
//  Copyright (c) 2013年 刘文景. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCBlockService : NSObject
- (void)setStillPosition:(RCPosition) position AtIndex:(RCIndex) index;
- (RCPosition)getStillPositionAtIndex:(RCIndex)index;
- (void)setRotatingPosition:(RCPosition) position AtIndex:(RCIndex) index;
- (RCPosition)getRotatingPositionAtIndex:(RCIndex)index;
- (void)setStillRotation:(RCRotation) rotation AtIndex:(RCIndex) index;
- (RCRotation)getStillRotationAtIndex:(RCIndex)index;
- (void)setRotatingRotation:(RCRotation) rotation AtIndex:(RCIndex) index;
- (RCRotation)getRotatingRotationAtIndex:(RCIndex)index;
- (BOOL)isRotatingAtIndex:(RCIndex)index;
- (void)setIsRotating:(BOOL)rotating AtIndex:(RCIndex)index;
- (BOOL)isSetColorNeededAtIndex:(RCIndex)index;
@end
