//
//  SRStructs.h
//  Sling Rings
//
//  Created by Stuart Lynch on 20/02/2016.
//  Copyright © 2016 uea.ac.uk. All rights reserved.
//

struct SRPoint {
    float x;
    float y;
    float z;
};
typedef struct SRPoint SRPoint;

struct SRColor {
    float r;
    float g;
    float b;
    float a;
};
typedef struct SRColor SRColor;

typedef struct {
    SRPoint point;
    SRColor color;
} SRVertex;

SRPoint SRPointMake(float x, float y, float z);
SRColor SRColorMake(float r, float g, float b, float a);
SRVertex SRVertexMake(SRPoint point, SRColor color);