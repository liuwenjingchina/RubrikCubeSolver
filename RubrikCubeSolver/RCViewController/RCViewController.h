//
//  RCViewController.h
//  RubrikCubeSolver
//
//  Created by 刘文景 on 13-9-1.
//  Copyright (c) 2013年 刘文景. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>
@class RCCube;
@interface RCViewController : GLKViewController
{
    GLuint _program;
    GLuint _vertexBuffer;
    GLuint _colorBuffer;
    NSInteger _frameCounter;
    BOOL _clearScreen;
}
@property (strong, nonatomic) RCCube *cubeManager;
- (void)_fpstimeout;

@end

@interface RCViewController(GLSetup)
- (void) _setupOpenGL;
- (BOOL) _loadShaders;
- (BOOL)_compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file;
- (BOOL)_linkProgram:(GLuint)prog;
- (BOOL)_validateProgram:(GLuint)prog;
- (void)_tearDownGL;
@end