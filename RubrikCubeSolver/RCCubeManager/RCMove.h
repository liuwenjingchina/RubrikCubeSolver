//
//  RCMove.h
//  ;
//
//  Created by 刘文景 on 13-9-7.
//  Copyright (c) 2013年 刘文景. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCMove : NSObject
{
    NSInteger moveID;
    RCMoveDescriptor moveType;
    float completeness;
}
@property(atomic)NSInteger moveID;
@property(atomic)RCMoveDescriptor moveType;
@property(atomic)float completeness;
+(id)moveWithType:(RCMoveDescriptor)moveType1;
-(id)initWithType:(RCMoveDescriptor)moveType1;
-(RCRotation)rotation;
@end
