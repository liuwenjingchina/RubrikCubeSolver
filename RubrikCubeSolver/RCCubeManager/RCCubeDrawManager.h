//
//  RCCubeDrawManager.h
//  RubrikCubeSolver
//
//  Created by 刘文景 on 13-9-1.
//  Copyright (c) 2013年 刘文景. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RCBlockService,
RCCubeService,
RCCubeMoveManager;
@interface RCCubeDrawManager : NSObject
@property (weak, atomic) RCBlockService *BlockService;
@property (weak, nonatomic) RCCubeMoveManager *CubeMoveManager;
-(void)drawInRect:(CGRect)rect;
-(void)cubeService:(RCCubeService *)cubeService DidChangedVisibility:(BOOL)visibility;

@end
