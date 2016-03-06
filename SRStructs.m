//
//  SRStruct.m
//  Sling Rings
//
//  Created by Stuart Lynch on 20/02/2016.
//  Copyright © 2016 uea.ac.uk. All rights reserved.
//

#import "SRStructs.h"

SRRect SRRectMake(float x, float y, float width, float height) {
    SRRect rect;
    rect.x = x;
    rect.y = y;
    rect.width = width;
    rect.height = height;
    return rect;
}

SRPoint SRPointMake(float x, float y, float z)  {
    SRPoint point;
    point.x = x;
    point.y = y;
    point.z = z;
    return point;
}

SRColor SRColorMake(float r, float g, float b, float a) {
    SRColor color;
    color.r = r;
    color.g = g;
    color.b = b;
    color.a = a;
    return color;
}

SRTexCoord SRTexCoordMake(float x, float y) {
    SRTexCoord texCoord;
    texCoord.x = x;
    texCoord.y = y;
    return texCoord;
}

SRVertex SRVertexMake(SRPoint point, SRColor color, SRTexCoord texCoord) {
    SRVertex vertex;
    vertex.point = point;
    vertex.color = color;
    vertex.texCoord = texCoord;
    return vertex;
}