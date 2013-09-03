//
//  RCCubeManager.h
//  RubrikCubeSolver
//
//  Created by 刘文景 on 13-9-1.
//  Copyright (c) 2013年 刘文景. All rights reserved.
//

#import <Foundation/Foundation.h>

@class
EAGLContext,
RCCubeService,
RCCubeMoveManager,
RCCubeRotationManager,
RCCubeTouchManager,
RCCubeDrawManager,
RCBlockService;

@interface RCCubeManager : NSObject
@property (strong, atomic) RCCubeService* cubeService;
@property (strong, nonatomic) RCCubeMoveManager *cubeMoveManager;
@property (weak, nonatomic) RCCubeRotationManager *CubeRotationManager;
@property (strong, nonatomic) RCCubeTouchManager *cubeTouchManager;
@property (strong, nonatomic) RCCubeDrawManager *cubeDrawManager;
@property (weak, atomic) RCBlockService *BlockService;
@property (strong, nonatomic) EAGLContext *context;

-(void)setCubePosition:(RCPosition)position;
-(void)setCubeRotation:(RCRotation)rotation;
-(void)setCubeRotationSpeed:(RCSpeed)speed;
-(void)commitMove:(RCMove)move;
-(void)drawInRect:(CGRect)rect;
-(void)setVisibility:(BOOL)visibility;
-(BOOL)isVisible;
@end
