//
//  RCCubeMoveManager.h
//  RubrikCubeSolver
//
//  Created by 刘文景 on 13-9-1.
//  Copyright (c) 2013年 刘文景. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCBaseClass.h"
#import "RCCubeServiceDelegate.h"
@class RCCubeService,
RCBlockService,
RCCubeRotationManager,
RCMove;
@interface RCCubeMoveManager : RCBaseClass<RCCubeServiceDelegate>
@property (strong, nonatomic) RCCubeRotationManager *cubeRotationManager;
@property(weak, atomic)RCCubeService *CubeService;
@property(weak, atomic)RCBlockService *BlockService;
-(void)queueInMove:(RCMoveDescriptor)move;
-(RCMove *)newMove;
-(void)endMove:(RCMove *)endMove;
-(void)setCurrentMove:(RCMove *)currentMove;
-(RCMove *)currentMove;
@end
