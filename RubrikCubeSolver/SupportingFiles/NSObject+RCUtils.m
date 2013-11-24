//
//  NSObject+RCUtils.m
//  RubrikCubeSolver
//
//  Created by 刘文景 on 13-9-8.
//  Copyright (c) 2013年 刘文景. All rights reserved.
//

#import "NSObject+RCUtils.h"

@implementation NSObject (RCUtils)
-(RCRotation)makeRotationX:(int)x Y:(int)y Z:(int)z
{
    RCRotation rotation;
    rotation.x = x;
    rotation.y = y;
    rotation.z = z;
    return rotation;
}

-(RCIndex)makeIndexI:(int)i J:(int)j K:(int)k
{
    RCIndex index;
    index.i = i;
    index.j = j;
    index.k = k;
    return index;
}

-(unsigned char)getBit:(int32_t)bits AtIndex:(int)index
{
    index %= 32;
    
    bits = bits >> index;
    bits = bits & 0x1;
    return bits;
}
@end
