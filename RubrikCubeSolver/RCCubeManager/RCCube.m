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
    RCLog(@"start allocation");
    // alloc self
    RCCube *cube = [super alloc];
    RCAssert(self, @"alloc failure");
    if (!cube) return NULL;
    
    // alloc cube
    RCCubeService *cubeService = [RCCubeService alloc];
    RCCubeMoveManager *cubeMoveManager = [RCCubeMoveManager alloc];
    RCCubeTouchManager *cubeTouchManager = [RCCubeTouchManager alloc];
    RCCubeDrawManager *cubeDrawManager = [RCCubeDrawManager alloc];

    // assemble cube
    [cube setCubeService:cubeService];
    [cube setCubeMoveManager:cubeMoveManager];
    [cube setCubeTouchManager:cubeTouchManager];
    [cube setCubeDrawManager:cubeDrawManager];
    RCLog(@"finish allocation\n");
    return cube;
}

-(id)init
{
    RCLog(@"start initialization");
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

    [_CubeRotationManager setBlockService:_BlockService];
    [_CubeRotationManager setCubeService:self.cubeService];
    
    [self.cubeTouchManager setCubeService:self.cubeService];
    [self.cubeTouchManager addDelegate:self.CubeRotationManager];
    
    [self.cubeMoveManager setBlockService:self.BlockService];
    [self.cubeMoveManager setCubeService:self.cubeService];
    
    RCLog(@"finish initialization\n");
    return self;
}

-(void)SetCubePosition:(RCPosition)position
{
    [self.cubeService setCubePosition:position];
}

-(void)SetCubeRotation:(RCRotation)rotation
{
    [self.cubeService setCubeRotation:rotation];
}

-(void)SetCubeRotationSpeed:(RCSpeed)speed
{
    [self.cubeService setCubeRotationSpeed:speed];
}

-(void)SetVisibility:(BOOL)visibility
{
    RCLog(@"visibility %d\n", visibility);
    [self.cubeService setVisibility:visibility];
}

-(BOOL)IsVisible
{
    return [self.cubeService visibility];
}

-(void)CommitMove:(RCMoveDescriptor)move
{
    RCLog(@"start commitMove 0x%x", move);
    [self.cubeMoveManager queueInMove:move];
    RCLog(@"finish commitMove 0x%x\n", move);
}

-(void)DrawInRect:(CGRect)rect
{
    [self.cubeDrawManager drawInRect:rect];
}

-(void)TouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    RCLog(@"start touch");
    [self.cubeTouchManager touchesBegan:touches withEvent:event];
}
-(void)TouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.cubeTouchManager touchesMoved:touches withEvent:event];
}
-(void)TouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    RCLog(@"end touch\n");
    [self.cubeTouchManager touchesEnded:touches withEvent:event];
}

@end
