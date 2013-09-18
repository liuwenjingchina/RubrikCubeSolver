//
//  RCCubeTouchManager.h
//  RubrikCubeSolver
//
//  Created by 刘文景 on 13-9-1.
//  Copyright (c) 2013年 刘文景. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RCCubeService;
@interface RCCubeTouchManager : NSObject
@property (weak, atomic)RCCubeService *CubeService;
@property BOOL isTouching;
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;

-(void)addDelegate:(id)object;
-(void)removeDelegate:(id)object;

@end
