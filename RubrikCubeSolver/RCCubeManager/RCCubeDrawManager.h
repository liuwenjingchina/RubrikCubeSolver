//
//  RCCubeDrawManager.h
//  RubrikCubeSolver
//
//  Created by 刘文景 on 13-9-1.
//  Copyright (c) 2013年 刘文景. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCBaseClass.h"
@class RCBlockService,
RCCubeService,
RCCubeService,
RCCubeRotationManager,
RCCubeTouchManager;
@interface RCCubeDrawManager : RCBaseClass
@property (weak, atomic) RCBlockService *BlockService;
@property (weak, atomic) RCCubeService *CubeService;
//@property (strong, nonatomic) RCCubeRotationManager *CubeRotationManager;
//@property (weak, atomic)RCCubeTouchManager *CubeTouchManager;

-(void)drawInRect:(CGRect)rect;

@end
