//
//  RCCubeTouchManagerDelegate.h
//  RubrikCubeSolver
//
//  Created by 刘文景 on 13-9-3.
//  Copyright (c) 2013年 刘文景. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RCCubeTouchManager;
@protocol RCCubeTouchManagerDelegate <NSObject>
@optional
-(void)cubeTouchManager:(RCCubeTouchManager *)cubeTouchManager NotifyTouchBegin:(NSSet *)touchs;
-(void)cubeTouchManager:(RCCubeTouchManager *)cubeTouchManager NotifyTouchEnd:(NSSet *)touchs;
-(void)cubeTouchManager:(RCCubeTouchManager *)cubeTouchManager NotifyTouchMoveDistance:(float)distance;
@end
