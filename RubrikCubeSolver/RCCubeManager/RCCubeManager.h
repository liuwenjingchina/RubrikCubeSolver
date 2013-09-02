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
@property (strong, atomic) RCCubeService* cube;
@property (strong, nonatomic) RCCubeMoveManager *cubeMoveManager;
@property (strong, nonatomic) RCCubeRotationManager *cubeRotationManager;
@property (strong, nonatomic) RCCubeTouchManager *cubeTouchManager;
@property (strong, nonatomic) RCCubeDrawManager *cubeDrawManager;
@property (strong, atomic) RCBlockService *blockManager;
@property (strong, nonatomic) EAGLContext *context;

-(void)setCubePosition:(RCPosition)position;
-(void)setCubeRotation:(RCRotation)rotation;
-(void)setCubeRotationSpeed:(RCSpeed)speed;
-(void)commitMove:(RCMove)move;
-(void)drawInRect:(CGRect)rect;
-(void)setVisibility:(BOOL)visibility;
-(BOOL)isVisible;
@end
