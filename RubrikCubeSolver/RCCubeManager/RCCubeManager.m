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
    RCPosition _cubePosition;
    RCRotation _cubeRotation;
    RCSpeed _cubeRotationSpeed;
    BOOL _visibility;
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
    RCCubeService *cube = [RCCubeService alloc];
    cubeManager.cube = cube;
    
    // alloc cubeMoveManager
    RCCubeMoveManager *cubeMoveManager = [RCCubeMoveManager alloc];
    cubeManager.cubeMoveManager = cubeMoveManager;
    
    // alloc cubeRotationManager
    RCCubeRotationManager *cubeRotationManager = [RCCubeRotationManager alloc];
    cubeManager.cubeRotationManager = cubeRotationManager;
    
    // alloc cubeTouchManager
    RCCubeTouchManager *cubeTouchManager = [RCCubeTouchManager alloc];
    cubeManager.cubeTouchManager = cubeTouchManager;

    // alloc cubeDrawManager
    RCCubeDrawManager *cubeDrawManager = [RCCubeDrawManager alloc];
    cubeManager.cubeDrawManager = cubeDrawManager;
    
    // alloc blockManager
    RCBlockService *blockManager = [RCBlockService alloc];
    cubeManager.blockManager = blockManager;

    return cubeManager;
}

-(id)init
{
    // init self
    self = [super init];
    RCAssert(self, @"RCCubeManager not super init");
    if (!self) return NULL;
    
    // init strong objects
    self.blockManager = [self.blockManager init];
    
    self.cube = [self.cube init];
    [self.cube setBlockManager:self.blockManager];
    
    self.cubeMoveManager = [self.cubeMoveManager init];
    [self.cube setBlockManager:self.blockManager];
    
    self.cubeRotationManager = [self.cubeRotationManager init];
    [self.cubeRotationManager setBlockManager:self.blockManager];
    
    self.cubeTouchManager = [self.cubeTouchManager init];
    
    self.cubeDrawManager = [self.cubeDrawManager init];
    [self.cubeDrawManager setBlockManager:self.blockManager];
    
    return self;
}

-(void)setCubePosition:(RCPosition)position
{
    _cubePosition = position;
}

-(void)setCubeRotation:(RCRotation)rotation
{
    _cubeRotation = rotation;
}

-(void)setCubeRotationSpeed:(RCSpeed)speed
{
    _cubeRotationSpeed = speed;
}

-(void)setVisibility:(BOOL)visibility
{
    _visibility = visibility;
}

-(BOOL)isVisible
{
    return _visibility;
}

-(void)commitMove:(RCMove)move
{
    
}

-(void)drawInRect:(CGRect)rect
{
    [self.cubeDrawManager drawInRect:rect];
}


@end
