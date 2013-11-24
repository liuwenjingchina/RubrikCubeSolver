//
//  RCCubeManager.m
//  RubrikCubeSolver
//
//  Created by 刘文景 on 13-9-1.
//  Copyright (c) 2013年 刘文景. All rights reserved.
//
#import "RCCube.h"
#import "RCCubeService.h"
#import "RCCubeMoveManager.h"
#import "RCCubeRotationManager.h"
#import "RCCubeTouchManager.h"
#import "RCCubeDrawManager.h"
#import "RCBlockService.h"
@interface RCCube()
@property (strong, atomic) RCCubeService* cubeService;
@property (strong, nonatomic) RCCubeMoveManager *cubeMoveManager;
@property (weak, nonatomic) RCCubeRotationManager *CubeRotationManager;
@property (strong, nonatomic) RCCubeTouchManager *cubeTouchManager;
@property (strong, nonatomic) RCCubeDrawManager *cubeDrawManager;
@property (weak, atomic) RCBlockService *BlockService;
@end

@implementation RCCube

+ (id)alloc
{
    // alloc self
    RCCube *cubeManager = [super alloc];
    RCAssert(self, @"alloc failure");
    if (!cubeManager) return NULL;
    
    // alloc cube
    RCCubeService *cubeService = [RCCubeService alloc];
    RCCubeMoveManager *cubeMoveManager = [RCCubeMoveManager alloc];
    RCCubeTouchManager *cubeTouchManager = [RCCubeTouchManager alloc];
    RCCubeDrawManager *cubeDrawManager = [RCCubeDrawManager alloc];

    // assemble cube
    [cubeManager setCubeService:cubeService];
    [cubeManager setCubeMoveManager:cubeMoveManager];
    [cubeManager setCubeTouchManager:cubeTouchManager];
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
    self.BlockService = [self.cubeService blockService];
    self.CubeRotationManager = [self.cubeMoveManager cubeRotationManager];
        
    // assemble strong objects
    [self.cubeService addDelegate:self.CubeRotationManager];
    [self.cubeService addDelegate:self.cubeTouchManager];
    [self.cubeService addDelegate:self.cubeMoveManager];
    [self.cubeService addDelegate:self.cubeDrawManager];

    [self.cubeDrawManager setBlockService:_BlockService];
    [self.cubeDrawManager setCubeService:self.cubeService];
    //[self.cubeDrawManager setCubeRotationManager:_CubeRotationManager];

    [_CubeRotationManager setBlockService:_BlockService];
    [_CubeRotationManager setCubeService:self.cubeService];
    //[_CubeRotationManager setCubeMoveManager:self.cubeMoveManager];
    
    [self.cubeTouchManager setCubeService:self.cubeService];
    [self.cubeTouchManager addDelegate:self.CubeRotationManager];
    
    [self.cubeMoveManager setBlockService:self.BlockService];
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

-(void)commitMove:(RCMoveDescriptor)move
{
    [self.cubeMoveManager queueInMove:move];
}

-(void)drawInRect:(CGRect)rect
{
    [self.cubeDrawManager drawInRect:rect];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.cubeTouchManager touchesBegan:touches withEvent:event];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.cubeTouchManager touchesMoved:touches withEvent:event];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.cubeTouchManager touchesEnded:touches withEvent:event];
}

@end
