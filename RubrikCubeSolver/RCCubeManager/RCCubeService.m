//
//  RCCube.m
//  RubrikCubeSolver
//
//  Created by 刘文景 on 13-9-1.
//  Copyright (c) 2013年 刘文景. All rights reserved.
//

#import "RCCubeService.h"
#import "RCBlock.h"
@implementation RCCubeService

+(id)alloc
{
    // self alloc
    RCCubeService *cube = [super alloc];
    RCAssert(cube, @"alloc failure");
    return cube;
}

-(id)init
{
    //self init
    self = [super init];
    return self;
}

@end
