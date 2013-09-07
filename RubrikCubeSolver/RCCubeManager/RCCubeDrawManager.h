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
RCCubeService,
RCCubeRotationManager;
@interface RCCubeDrawManager : NSObject
@property (weak, atomic) RCBlockService *BlockService;
@property (weak, atomic) RCCubeService *CubeService;
@property (strong, nonatomic) RCCubeRotationManager *CubeRotationManager;
-(void)drawInRect:(CGRect)rect;

@end
