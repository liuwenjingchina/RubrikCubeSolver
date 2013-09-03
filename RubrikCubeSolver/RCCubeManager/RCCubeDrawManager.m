//
//  RCCubeDrawManager.m
//  RubrikCubeSolver
//
//  Created by 刘文景 on 13-9-1.
//  Copyright (c) 2013年 刘文景. All rights reserved.
//

#import "RCCubeDrawManager.h"
#import "RCBlockService.h"
#import "RCCubeService.h"
#import "RCCubeMoveManager.h"
#import <GLKit/GLKit.h>
@interface RCCubeDrawManager()
{
    BOOL _hasUpdate;
    BOOL _hasDrawn;
}
@end

@implementation RCCubeDrawManager
- (id)init
{
    self = [super init];
    RCAssert(self, @"init failure");
    _hasDrawn = NO;
    return self;
}

-(void)drawInRect:(CGRect)rect
{
    // if no update to draw and we have already drawn once of the same thing
    if (!_hasUpdate && _hasDrawn) return;
    
    // update flag
    _hasDrawn = YES;
    
    glClearColor(1, 1, 1, 1);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    // Projection Level
    float aspect = fabsf(rect.size.width / rect.size.height);
    GLKMatrix4 projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(60.0f), aspect, 0.1f, 100.0f);
        
    for (int i=0; i<3; i++) {
        for (int j=0; j<3; j++) {
            for (int k=0; k<3; k++){

                RCIndex index;
                index.i = i;
                index.j = j;
                index.k = k;
                
                // Cube Level
                RCRotation rotation;
                RCPosition position;
                if ([_BlockService isRotatingAtIndex:index]) {
                    position = [_BlockService getRotatingPositionAtIndex:index];
                    rotation = [_BlockService getRotatingRotationAtIndex:index];
                } else {
                    position = [_BlockService getStillPositionAtIndex:index];
                    rotation = [_BlockService getStillRotationAtIndex:index];
                }
                
                GLKMatrix4 cubePositionMatrix = GLKMatrix4MakeTranslation(position.x, position.y, position.z);
                GLKMatrix4 cubeMatrix = cubePositionMatrix;
                
                if (rotation.x || rotation.y || rotation.z) {
                    GLKMatrix4 cubeRotationMatrix = GLKMatrix4MakeRotation(1, rotation.x, rotation.y, rotation.z);
                    cubeMatrix = GLKMatrix4Multiply(cubeRotationMatrix, cubeMatrix);
                }
                
                GLKMatrix4 viewMatrix = GLKMatrix4MakeLookAt(6/1.5, 4/1.5, 9/1.5, 0, 0, 0, 0, 1, 0);
                GLKMatrix4 worldMatrix = GLKMatrix4MakeTranslation(0, 0.2, 0);
                
                // Assemble Levels
                GLKMatrix4 modelViewMatrix = GLKMatrix4Multiply(worldMatrix, cubeMatrix);
                modelViewMatrix = GLKMatrix4Multiply(viewMatrix, modelViewMatrix);
                GLKMatrix3 normalMatrix = GLKMatrix3InvertAndTranspose(GLKMatrix4GetMatrix3(modelViewMatrix), NULL);
                modelViewMatrix = GLKMatrix4Multiply(projectionMatrix, modelViewMatrix);
                
                // Register a render
                glUniformMatrix4fv(uniforms[UNIFORM_MODELVIEWPROJECTION_MATRIX], 1, 0, modelViewMatrix.m);
                glUniformMatrix3fv(uniforms[UNIFORM_NORMAL_MATRIX], 1, 0, normalMatrix.m);
                glDrawArrays(GL_TRIANGLES, 0, 36);
            }
        }
    }

}

-(void)cubeService:(id)cubeService DidChangedVisibility:(BOOL)visibility
{
    //update _drawNeeded
    RCCubeService *t_cubeService = cubeService;
    RCSpeed t_speed = [t_cubeService cubeRotationSpeed];
    RCMove  t_move = [_CubeMoveManager currentMove];
    _hasUpdate = YES;
    if(!visibility)_hasUpdate = NO; // if not visible no update
    if(!t_speed && !t_move) _hasUpdate = NO; //If no move no update
}
@end
