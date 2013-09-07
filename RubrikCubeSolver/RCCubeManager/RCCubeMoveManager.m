//
//  RCCubeMoveManager.m
//  RubrikCubeSolver
//
//  Created by 刘文景 on 13-9-1.
//  Copyright (c) 2013年 刘文景. All rights reserved.
//

#import "RCCubeMoveManager.h"
#import "RCCubeRotationManager.h"
#import "RCCubeService.h"
@implementation RCCubeMoveManager
+(id)alloc
{
    RCCubeMoveManager *cubeMoveManager = [super alloc];
    RCCubeRotationManager *cubeRotationManager = [RCCubeRotationManager alloc];
    RCAssert(cubeMoveManager&&cubeMoveManager, @"alloc failure");
    cubeMoveManager.cubeRotationManager = cubeRotationManager;
    return cubeMoveManager;
}

-(id)init
{
    RCCubeRotationManager *cubeRotationManager = [self.cubeRotationManager init];
    self = [super init];
    RCAssert(self, @"init failure");
    self.cubeRotationManager = cubeRotationManager;
    return self;
}

-(RCMove)currentMove
{
    return [self.cubeRotationManager currentMove];
}

@end
