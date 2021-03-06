//
//  RCTypes.h
//  RubrikCubeSolver
//
//  Created by 刘文景 on 13-9-1.
//  Copyright (c) 2013年 刘文景. All rights reserved.
//

#ifndef RubrikCubeSolver_RCTypes_h
#define RubrikCubeSolver_RCTypes_h

typedef struct RCPosition{
    float x;
    float y;
    float z;
} RCPosition;

typedef struct RCRotation {
    unsigned char x;
    unsigned char y;
    unsigned char z;
} RCRotation;

typedef struct RCIndex{
    int i;
    int j;
    int k;
}RCIndex;

typedef float RCSpeed;
typedef enum RCMoveDescriptor {
    RCMoveStill = 0x00000000,
    RCMoveL     = 0x49249249,
}RCMoveDescriptor;
#endif
