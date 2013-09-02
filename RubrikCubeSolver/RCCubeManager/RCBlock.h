//
//  RCBlock.h
//  RubrikCubeSolver
//
//  Created by 刘文景 on 13-9-1.
//  Copyright (c) 2013年 刘文景. All rights reserved.
//

#ifndef RubrikCubeSolver_RCBlock_h
#define RubrikCubeSolver_RCBlock_h

typedef struct RCBlock {
    
    RCPosition stillPosition;
    RCRotation stillRotation;
    
    RCPosition rotatingPosition;
    RCRotation rotatingRotation;
    
    BOOL isRotating;
    
    //Need more color to find the rotation of the block
    BOOL isSetColorNeeded;
    
} RCBlock;

#endif
