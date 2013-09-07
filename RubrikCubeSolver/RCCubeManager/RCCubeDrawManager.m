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
#import "RCCubeRotationManager.h"
#import <GLKit/GLKit.h>
@interface RCCubeDrawManager()
{
    BOOL _firstDraw;
}
@end

@implementation RCCubeDrawManager
- (id)init
{
    self = [super init];
    RCAssert(self, @"init failure");
    _firstDraw = YES;
    return self;
}

-(void)drawInRect:(CGRect)rect
{
    // if no update to draw and we have already drawn once of the same thing
    if (!_firstDraw && !_CubeRotationManager.hasUpdate) return;
    _firstDraw = NO; //have already drawn
    [_CubeRotationManager setHasUpdate:NO];
    
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
                
                // Block Level
                RCRotation rotation;
                RCPosition position;
                if ([_BlockService isRotatingAtIndex:index]) {
                    position = [_BlockService getRotatingPositionAtIndex:index];
                    rotation = [_BlockService getRotatingRotationAtIndex:index];
                } else {
                    position = [_BlockService getStillPositionAtIndex:index];
                    rotation = [_BlockService getStillRotationAtIndex:index];
                }
                
                GLKMatrix4 blockPositionMatrix = GLKMatrix4MakeTranslation(position.x, position.y, position.z);
                GLKMatrix4 blockMatrix = blockPositionMatrix;
                
                if (rotation.x || rotation.y || rotation.z) {
                    GLKMatrix4 blockRotationMatrix = GLKMatrix4MakeRotation(1, rotation.x, rotation.y, rotation.z);
                    blockMatrix = GLKMatrix4Multiply(blockRotationMatrix, blockMatrix);
                }
                
                // Cube Level
                GLKMatrix4 cubeMatrix = GLKMatrix4MakeTranslation(0, 0, 0);
                float rotationChange = _CubeService.cubeRotation.y;
                if (rotationChange) {
                    cubeMatrix = GLKMatrix4MakeRotation(rotationChange, 0, 1, 0);
                }
                
                // World Level
                RCPosition cubePosition = _CubeService.cubePosition;
                GLKMatrix4 worldMatrix = GLKMatrix4MakeTranslation(cubePosition.x, cubePosition.y, cubePosition.z);
                
                // Camera Level
                GLKMatrix4 cameraMatrix = GLKMatrix4MakeLookAt(6/1.5, 4/1.5, 9/1.5, 0, 0, 0, 0, 1, 0);
                
                // Assemble Levels
                GLKMatrix4 modelViewMatrix = blockMatrix;
                modelViewMatrix = GLKMatrix4Multiply(cubeMatrix, modelViewMatrix);
                modelViewMatrix = GLKMatrix4Multiply(worldMatrix, modelViewMatrix);
                modelViewMatrix = GLKMatrix4Multiply(cameraMatrix, modelViewMatrix);
                
                // Final Matrices
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

@end
