//
//  RCCubeManager.h
//  RubrikCubeSolver
//
//  Created by 刘文景 on 13-9-1.
//  Copyright (c) 2013年 刘文景. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCBaseClass.h"

@class
EAGLContext,
RCCubeService,
RCCubeMoveManager,
RCCubeRotationManager,
RCCubeTouchManager,
RCCubeDrawManager,
RCBlockService;

@interface RCCube : RCBaseClass
@property (strong, nonatomic) EAGLContext *context;

-(void)SetCubePosition:(RCPosition)position;
-(void)SetCubeRotation:(RCRotation)rotation;
-(void)SetCubeRotationSpeed:(RCSpeed)speed;
-(void)CommitMove:(RCMoveDescriptor)move;
-(void)DrawInRect:(CGRect)rect;
-(void)SetVisibility:(BOOL)visibility;
-(BOOL)IsVisible;
-(void)TouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)TouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)TouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
@end
