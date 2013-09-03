//
//  RCCubeRotationManager.h
//  RubrikCubeSolver
//
//  Created by 刘文景 on 13-9-1.
//  Copyright (c) 2013年 刘文景. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RCBlockService,
RCCubeService;
@interface RCCubeRotationManager : NSObject
@property (weak, atomic)RCBlockService *BlockService;
@property (weak, atomic)RCCubeService *CubeService;
@property RCMove currentMove;
-(void)cubeService:(RCCubeService *)cubeService DidChangedVisibility:(BOOL)visibility;
@end
