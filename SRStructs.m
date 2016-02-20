//
//  SRStruct.m
//  Sling Rings
//
//  Created by Stuart Lynch on 20/02/2016.
//  Copyright © 2016 uea.ac.uk. All rights reserved.
//

#import "SRStructs.h"

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

SRVertex SRVertexMake(SRPoint point, SRColor color) {
    SRVertex vertex;
    vertex.point = point;
    vertex.color = color;
    return vertex;
}