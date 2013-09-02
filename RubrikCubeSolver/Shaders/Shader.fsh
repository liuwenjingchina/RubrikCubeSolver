//
//  Shader.fsh
//  RubikCube
//
//  Created by 刘文景 on 13-5-4.
//  Copyright (c) 2013年 刘文景. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
