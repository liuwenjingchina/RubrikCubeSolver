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
    [self.cubeManager TouchesBegan:touches withEvent:event];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.cubeManager TouchesMoved:touches withEvent:event];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.cubeManager TouchesEnded:touches withEvent:event];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{

}
@end
