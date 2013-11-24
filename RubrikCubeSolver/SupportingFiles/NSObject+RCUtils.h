//
//  NSObject+RCUtils.h
//  RubrikCubeSolver
//
//  Created by 刘文景 on 13-9-8.
//  Copyright (c) 2013年 刘文景. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (RCUtils)
- (RCRotation) makeRotationX:(int)x Y:(int)y Z:(int)z;

- (unsigned char) getBit:(int32_t)bits AtIndex:(int)index;

-(RCIndex)makeIndexI:(int)i J:(int)j K:(int)k;

@end
