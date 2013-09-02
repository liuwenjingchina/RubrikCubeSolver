//
//  RCCubeData.h
//  RubrikCubeSolver
//
//  Created by 刘文景 on 13-9-1.
//  Copyright (c) 2013年 刘文景. All rights reserved.
//

#ifndef RubrikCubeSolver_RCCubeData_h
#define RubrikCubeSolver_RCCubeData_h

//CubeVertexData
GLfloat gCubeVertexData[216] =
{
    // Data layout for each line below is:
    // positionX, positionY, positionZ,     normalX, normalY, normalZ,
    0.49f, -0.49f, -0.49f,        1.0f, 0.0f, 0.0f,
    0.49f, 0.49f, -0.49f,         1.0f, 0.0f, 0.0f,
    0.49f, -0.49f, 0.49f,         1.0f, 0.0f, 0.0f,
    0.49f, -0.49f, 0.49f,         1.0f, 0.0f, 0.0f,
    0.49f, 0.49f, -0.49f,          1.0f, 0.0f, 0.0f,
    0.49f, 0.49f, 0.49f,         1.0f, 0.0f, 0.0f,
    
    0.49f, 0.49f, -0.49f,         0.0f, 1.0f, 0.0f,
    -0.49f, 0.49f, -0.49f,        0.0f, 1.0f, 0.0f,
    0.49f, 0.49f, 0.49f,          0.0f, 1.0f, 0.0f,
    0.49f, 0.49f, 0.49f,          0.0f, 1.0f, 0.0f,
    -0.49f, 0.49f, -0.49f,        0.0f, 1.0f, 0.0f,
    -0.49f, 0.49f, 0.49f,         0.0f, 1.0f, 0.0f,
    
    -0.49f, 0.49f, -0.49f,        -1.0f, 0.0f, 0.0f,
    -0.49f, -0.49f, -0.49f,       -1.0f, 0.0f, 0.0f,
    -0.49f, 0.49f, 0.49f,         -1.0f, 0.0f, 0.0f,
    -0.49f, 0.49f, 0.49f,         -1.0f, 0.0f, 0.0f,
    -0.49f, -0.49f, -0.49f,       -1.0f, 0.0f, 0.0f,
    -0.49f, -0.49f, 0.49f,        -1.0f, 0.0f, 0.0f,
    
    -0.49f, -0.49f, -0.49f,       0.0f, -1.0f, 0.0f,
    0.49f, -0.49f, -0.49f,        0.0f, -1.0f, 0.0f,
    -0.49f, -0.49f, 0.49f,        0.0f, -1.0f, 0.0f,
    -0.49f, -0.49f, 0.49f,        0.0f, -1.0f, 0.0f,
    0.49f, -0.49f, -0.49f,        0.0f, -1.0f, 0.0f,
    0.49f, -0.49f, 0.49f,         0.0f, -1.0f, 0.0f,
    
    0.49f, 0.49f, 0.49f,          0.0f, 0.0f, 1.0f,
    -0.49f, 0.49f, 0.49f,         0.0f, 0.0f, 1.0f,
    0.49f, -0.49f, 0.49f,         0.0f, 0.0f, 1.0f,
    0.49f, -0.49f, 0.49f,         0.0f, 0.0f, 1.0f,
    -0.49f, 0.49f, 0.49f,         0.0f, 0.0f, 1.0f,
    -0.49f, -0.49f, 0.49f,        0.0f, 0.0f, 1.0f,
    
    0.49f, -0.49f, -0.49f,        0.0f, 0.0f, -1.0f,
    -0.49f, -0.49f, -0.49f,       0.0f, 0.0f, -1.0f,
    0.49f, 0.49f, -0.49f,         0.0f, 0.0f, -1.0f,
    0.49f, 0.49f, -0.49f,         0.0f, 0.0f, -1.0f,
    -0.49f, -0.49f, -0.49f,       0.0f, 0.0f, -1.0f,
    -0.49f, 0.49f, -0.49f,        0.0f, 0.0f, -1.0f
};

//Color Data
#define White 1,1,1
#define Yellow 1,1,0
#define Blue  0,0,1
#define Red   1,0,0
#define Orange 1,0.5,0
#define Green 0,1,0

static const GLfloat gColorData[] = {
    Yellow,Yellow,Yellow,Yellow,Yellow,Yellow,
    Blue,Blue,Blue,Blue,Blue,Blue,
    White,White,White,White,White,White,
    Green,Green,Green,Green,Green,Green,
    Red,Red,Red,Red,Red,Red,
    Orange,Orange,Orange,Orange,Orange,Orange
};

#endif
