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
//#import "RCCubeMoveManager.h"
//#import "RCCubeRotationManager.h"
//#import "RCCubeDrawManager.h"
#import "RCCubeServiceDelegate.h"
@interface RCCubeService()
{
    BOOL _visibility;
    RCSpeed _cubeRotationSpeed;
}
@property(strong, nonatomic)NSMutableArray *Delegates;
@end

@implementation RCCubeService
+(id)alloc
{
    // self alloc
    RCCubeService *cube = [super alloc];
    
    // alloc strong objects
    RCBlockService *blockService = [RCBlockService alloc];
    cube.blockService = blockService;
    
    NSMutableArray *delegates = [[NSMutableArray alloc]initWithCapacity:10];
    cube.Delegates = delegates;
    
    RCAssert(cube && blockService, @"alloc failure");
    return cube;
}

-(id)init
{
    //self init
    self = [super init];
    self.blockService = [self.blockService init];
    RCAssert(self, @"init failure");
    
    //Init cubePosition
    RCPosition cubePosition;
    cubePosition.x = 0;
    cubePosition.y = 0.2;
    cubePosition.z = 0;
    self.cubePosition = cubePosition;
    
    //Init Visisbility
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
    for (id<RCCubeServiceDelegate>delegate in _Delegates) {
        if ([delegate respondsToSelector:@selector(cubeService:NotifyChange:)]){
            [delegate cubeService:self NotifyChange:RCCubeServiceChangeCubeVisibility];
        }
    }
}

-(void)setCubeRotationSpeed:(RCSpeed)cubeRotationSpeed
{
    _cubeRotationSpeed = cubeRotationSpeed;
    
    //Notify RotationSpeed change
    for (id<RCCubeServiceDelegate>delegate in _Delegates) {
        if ([delegate respondsToSelector:@selector(cubeService:NotifyChange:)]){
            [delegate cubeService:self NotifyChange:RCCubeServiceChangeCubeRotationSpeed];
        }
    }
}

-(RCSpeed)cubeRotationSpeed
{
    return _cubeRotationSpeed;
}

-(void)notifyCubeWillDraw
{
    for (id<RCCubeServiceDelegate>delegate in _Delegates) {
        if ([delegate respondsToSelector:@selector(cubeServiceWillDraw:)]){
            [delegate cubeServiceWillDraw:self];
        }
    }
}

-(void)notifyCubeDidDraw
{
    for (id<RCCubeServiceDelegate>delegate in _Delegates) {
        if ([delegate respondsToSelector:@selector(cubeServiceDidDraw:)]){
            [delegate cubeServiceDidDraw:self];
        }
    }
}

-(void)addDelegate:(id)object
{
    [_Delegates addObject:object];
}

-(void)removeDelegate:(id)object
{
    [_Delegates removeObject:object];
}

@end
