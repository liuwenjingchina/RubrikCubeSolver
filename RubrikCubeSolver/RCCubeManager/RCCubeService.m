//
//  RCCube.m
//  RubrikCubeSolver
//
//  Created by 刘文景 on 13-9-1.
//  Copyright (c) 2013年 刘文景. All rights reserved.
//

#import "RCCubeService.h"
#import "RCBlockService.h"
#import "RCBlock.h"
#import "RCCubeMoveManager.h"
#import "RCCubeRotationManager.h"
#import "RCCubeDrawManager.h"
@interface RCCubeService()
{
    BOOL _visibility;
}
@end

@implementation RCCubeService
+(id)alloc
{
    // self alloc
    RCCubeService *cube = [super alloc];
    RCBlockService *blockService = [RCBlockService alloc];
    cube.blockService = blockService;
    RCAssert(cube && blockService, @"alloc failure");
    return cube;
}

-(id)init
{
    //self init
    self = [super init];
    self.blockService = [self.blockService init];
    RCAssert(self, @"init failure");
    _visibility = NO;
    return self;
}

-(BOOL)visibility
{
    return _visibility;
}

-(void)setVisibility:(BOOL)visibility
{
    _visibility = visibility;
    
    // Notify Visibility change
    [_CubeMoveManager cubeService:self DidChangedVisibility:visibility];
    [_CubeRotationManager cubeService:self DidChangedVisibility:visibility];
    [_CubeDrawManager cubeService:self DidChangedVisibility:visibility];
}

@end
