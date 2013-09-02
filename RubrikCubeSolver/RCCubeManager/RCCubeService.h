//
//  RCCube.h
//  RubrikCubeSolver
//
//  Created by 刘文景 on 13-9-1.
//  Copyright (c) 2013年 刘文景. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCBlock.h"
@class RCBlockService;
@interface RCCubeService : NSObject
{
    RCBlock _blocks [3][3][3];
}
@property (weak, atomic)RCBlockService *BlockManager;

@end
