//
//  RCCubeMoveManager.h
//  RubrikCubeSolver
//
//  Created by 刘文景 on 13-9-1.
//  Copyright (c) 2013年 刘文景. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCCubeServiceDelegate.h"
@class RCCubeService,
RCCubeRotationManager;
@interface RCCubeMoveManager : NSObject<RCCubeServiceDelegate>
@property (strong, nonatomic) RCCubeRotationManager *cubeRotationManager;
-(RCMove)currentMove;
@end
