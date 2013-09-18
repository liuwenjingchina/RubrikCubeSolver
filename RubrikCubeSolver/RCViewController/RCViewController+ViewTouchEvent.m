//
//  RCViewController+ViewTouchEvent.m
//  RubrikCubeSolver
//
//  Created by 刘文景 on 13-9-2.
//  Copyright (c) 2013年 刘文景. All rights reserved.
//

#import "RCViewController+ViewTouchEvent.h"
#import "RCCube.h"
@implementation RCViewController (ViewTouchEvent)
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.cubeManager touchesBegan:touches withEvent:event];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.cubeManager touchesMoved:touches withEvent:event];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.cubeManager touchesEnded:touches withEvent:event];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{

}
@end
