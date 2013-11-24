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
@optional
-(void)cubeService:(RCCubeService *)cubeService NotifyChange:(RCCubeServiceChange)change;
-(void)cubeServiceWillDraw:(RCCubeService *)cubeService;
-(void)cubeServiceDidDraw:(RCCubeService *)cubeService;
-(void)cubeServiceDidFinishCurrentMove:(RCCubeService *)cubeService;
-(void)cubeServiceStartNewMove:(RCCubeService *)cubeService;
@end
