//
//  RCCubeRotationManager.h
//  RubrikCubeSolver
//
//  Created by 刘文景 on 13-9-1.
//  Copyright (c) 2013年 刘文景. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCCubeServiceDelegate.h"
#import "RCCubeTouchManagerDelegate.h"
@class RCBlockService,
RCCubeService;
@interface RCCubeRotationManager : NSObject<RCCubeServiceDelegate,RCCubeTouchManagerDelegate>
@property (weak, atomic)RCBlockService *BlockService;
@property (weak, atomic)RCCubeService *CubeService;
@property RCMove currentMove;
@property BOOL hasUpdate;
@end
