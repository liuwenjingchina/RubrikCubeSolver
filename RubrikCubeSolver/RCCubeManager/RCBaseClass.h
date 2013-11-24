//
//  RCBaseClass.h
//  RubrikCubeSolver
//
//  Created by 刘文景 on 13-11-24.
//  Copyright (c) 2013年 刘文景. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
typedef struct RCPosition{
    float x;
    float y;
    float z;
} RCPosition;

typedef struct RCRotation {
    float x;
    float y;
    float z;
} RCRotation;

typedef struct RCIndex{
    int i;
    int j;
    int k;
}RCIndex;

typedef struct RCStillRotation{
    short x :2;
    short y :2;
    short z :2;
} RCStillRotation;

typedef struct RCBlock {
    RCPosition stillPosition;
    GLKMatrix4 stillRotation;
} RCBlock;

typedef float RCSpeed;
typedef enum RCMoveDescriptor {
    RCMoveStill = 0x00000000,
    RCMoveL     = 0xc1249249,
    RCMoveLP    = 0x01249249,
    RCMoveR     = 0x04924924,
    RCMoveRP    = 0xc4924924,
    RCMoveU     = 0x001C0E07,
    RCMoveUP    = 0xc01c0e07,
    RCMoveD     = 0xc70381C0,
    RCMoveDP    = 0x070381C0,
    RCMoveF     = 0x400001FF,
    RCMoveFP    = 0x800001FF,
    RCMoveB     = 0x87FC0000,
    RCMoveBP    = 0x47FC0000
}RCMoveDescriptor;


@interface RCBaseClass : NSObject
- (RCStillRotation) makeRotationX:(int)x Y:(int)y Z:(int)z;

- (unsigned char) getBit:(int32_t)bits AtIndex:(int)index;
@end
