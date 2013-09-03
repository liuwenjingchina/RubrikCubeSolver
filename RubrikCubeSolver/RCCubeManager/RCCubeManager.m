//
//  RCCubeManager.m
//  RubrikCubeSolver
//
//  Created by 刘文景 on 13-9-1.
//  Copyright (c) 2013年 刘文景. All rights reserved.
//
#import "RCCubeManager.h"
#import "RCCubeService.h"
#import "RCCubeMoveManager.h"
#import "RCCubeRotationManager.h"
#import "RCCubeTouchManager.h"
#import "RCCubeDrawManager.h"
#import "RCBlockService.h"
@interface RCCubeManager()
{

}
@end

@implementation RCCubeManager

+ (id)alloc
{
    // alloc self
    RCCubeManager *cubeManager = [super alloc];
    RCAssert(self, @"alloc failure");
    if (!cubeManager) return NULL;
    
    // alloc cube
    RCCubeService *cubeService = [RCCubeService alloc];
    [cubeManager setCubeService:cubeService];
    
    // alloc cubeMoveManager
    RCCubeMoveManager *cubeMoveManager = [RCCubeMoveManager alloc];
    [cubeManager setCubeMoveManager:cubeMoveManager];
    
    // alloc cubeTouchManager
    RCCubeTouchManager *cubeTouchManager = [RCCubeTouchManager alloc];
    [cubeManager setCubeTouchManager:cubeTouchManager];
    
    // alloc cubeDrawManager
    RCCubeDrawManager *cubeDrawManager = [RCCubeDrawManager alloc];
    [cubeManager setCubeDrawManager:cubeDrawManager];
    return cubeManager;
}

-(id)init
{
    // init self
    self = [super init];
    RCAssert(self, @"RCCubeManager not super init");
    if (!self) return NULL;
    
    // init strong objects
    self.cubeService = [self.cubeService init];
    self.cubeMoveManager = [self.cubeMoveManager init];
    self.cubeTouchManager = [self.cubeTouchManager init];
    self.cubeDrawManager = [self.cubeDrawManager init];
    
    // assemble self
    _BlockService = [self.cubeService blockService];
    _CubeRotationManager = [self.cubeMoveManager cubeRotationManager];
        
    // assemble strong objects
    [self.cubeService setBlockService:[self.cubeService blockService]];
    [self.cubeService setCubeMoveManager:self.cubeMoveManager];
    [self.cubeService setCubeDrawManager:self.cubeDrawManager];
    [self.cubeService setCubeRotationManager:[self.cubeMoveManager cubeRotationManager]];
        [self.cubeDrawManager setBlockService:_BlockService];
    [self.cubeDrawManager setCubeMoveManager:self.cubeMoveManager];
    [_CubeRotationManager setBlockService:_BlockService];
    [_CubeRotationManager setCubeService:self.cubeService];

    return self;
}

-(void)setCubePosition:(RCPosition)position
{
    [self.cubeService setCubePosition:position];
}

-(void)setCubeRotation:(RCRotation)rotation
{
    [self.cubeService setCubeRotation:rotation];
}

-(void)setCubeRotationSpeed:(RCSpeed)speed
{
    [self.cubeService setCubeRotationSpeed:speed];
}

-(void)setVisibility:(BOOL)visibility
{
    [self.cubeService setVisibility:visibility];
}

-(BOOL)isVisible
{
    return [self.cubeService visibility];
}

-(void)commitMove:(RCMove)move
{
    
}

-(void)drawInRect:(CGRect)rect
{
    [self.cubeDrawManager drawInRect:rect];
}


@end
