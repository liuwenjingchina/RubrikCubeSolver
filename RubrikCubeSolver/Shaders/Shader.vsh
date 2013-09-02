//
//  Shader.vsh
//  RubikCube
//
//  Created by 刘文景 on 13-5-4.
//  Copyright (c) 2013年 刘文景. All rights reserved.
//

attribute vec4 position;
attribute vec3 normal;
attribute vec4 color;

varying lowp vec4 colorVarying;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;
void main()
{
    vec3 eyeNormal = normalize(normalMatrix * normal);
    vec3 lightPosition = vec3(0.0, 0.0, 1.0);
    
    float nDotVP = max(0.0, dot(eyeNormal, normalize(lightPosition*lightPosition)));
                 
    colorVarying = color * nDotVP;
    
    gl_Position = modelViewProjectionMatrix * position;
}
