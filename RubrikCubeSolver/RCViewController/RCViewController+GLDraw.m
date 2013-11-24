//
//  RCViewController+GLDraw.m
//  RubrikCubeSolver
//
//  Created by 刘文景 on 13-9-1.
//  Copyright (c) 2013年 刘文景. All rights reserved.
//

#import "RCViewController+GLDraw.h"
#import "RCCube.h"
@implementation RCViewController (GLDraw)
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    if (_clearScreen) {
        glClearColor(1, 1, 1, 1);
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
        _clearScreen = NO;
    }
    
    //frameCounter update
#ifdef DEBUG
    _frameCounter++;
#endif
    
    if ([self.cubeManager IsVisible]) {
        [self.cubeManager DrawInRect:rect];
    }
}

@end
