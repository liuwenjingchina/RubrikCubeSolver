//
//  RCViewController+GLDraw.m
//  RubrikCubeSolver
//
//  Created by 刘文景 on 13-9-1.
//  Copyright (c) 2013年 刘文景. All rights reserved.
//

#import "RCViewController+GLDraw.h"
#import "RCCubeManager.h"
@implementation RCViewController (GLDraw)
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    if ([self.cubeManager isVisible]) {
        [self.cubeManager drawInRect:rect];
    }
}

@end
