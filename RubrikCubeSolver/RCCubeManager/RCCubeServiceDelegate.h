//
//  RCCubeServiceDelegate.h
//  RubrikCubeSolver
//
//  Created by 刘文景 on 13-9-2.
//  Copyright (c) 2013年 刘文景. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum RCCubeServiceChange {
    RCCubeServiceChangeCubeRotationSpeed,
    RCCubeServiceChangeCubeVisibility,
}RCCubeServiceChange;

@class RCCubeService;
@protocol RCCubeServiceDelegate <NSObject>
-(void)cubeService:(RCCubeService *)cubeService NotifyChange:(RCCubeServiceChange)change;
@end