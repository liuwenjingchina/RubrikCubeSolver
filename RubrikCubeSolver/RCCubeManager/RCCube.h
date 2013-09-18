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

@interface RCCube : NSObject
@property (strong, nonatomic) EAGLContext *context;

-(void)setCubePosition:(RCPosition)position;
-(void)setCubeRotation:(RCRotation)rotation;
-(void)setCubeRotationSpeed:(RCSpeed)speed;
-(void)commitMove:(RCMoveDescriptor)move;
-(void)drawInRect:(CGRect)rect;
-(void)setVisibility:(BOOL)visibility;
-(BOOL)isVisible;
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
@end
