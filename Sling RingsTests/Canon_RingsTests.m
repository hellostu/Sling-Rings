//
//  Sling_RingsTests.m
//  Sling RingsTests
//
//  Created by Stuart Lynch on 26/01/2016.
//  Copyright © 2016 uea.ac.uk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SRMatrix.h"

@interface Sling_RingsTests : XCTestCase

@end

@implementation Sling_RingsTests

- (void)testMatrixMultiplication {
    SRMatrix *matrix1 = [[SRMatrix alloc] initWithHeight:3 width:3];
    [matrix1 setValue:2  atI:0 J:0];
    [matrix1 setValue:3  atI:0 J:1];
    [matrix1 setValue:4  atI:0 J:2];
    [matrix1 setValue:5  atI:1 J:0];
    [matrix1 setValue:6  atI:1 J:1];
    [matrix1 setValue:7  atI:1 J:2];
    [matrix1 setValue:8  atI:2 J:0];
    [matrix1 setValue:9  atI:2 J:1];
    [matrix1 setValue:10 atI:2 J:2];
    
    SRMatrix *matrix2 = [[SRMatrix alloc] initWithHeight:3 width:3];
    [matrix2 setValue:-5  atI:0 J:0];
    [matrix2 setValue:-4  atI:0 J:1];
    [matrix2 setValue:-3  atI:0 J:2];
    [matrix2 setValue:-2  atI:1 J:0];
    [matrix2 setValue:-1  atI:1 J:1];
    [matrix2 setValue: 0  atI:1 J:2];
    [matrix2 setValue: 1  atI:2 J:0];
    [matrix2 setValue: 2  atI:2 J:1];
    [matrix2 setValue: 3  atI:2 J:2];
    
    SRMatrix *actualAnswer = [[SRMatrix alloc] initWithHeight:3 width:3];
    [actualAnswer setValue:-12 atI:0 J:0];
    [actualAnswer setValue:-3  atI:0 J:1];
    [actualAnswer setValue: 6  atI:0 J:2];
    [actualAnswer setValue:-30 atI:1 J:0];
    [actualAnswer setValue:-12 atI:1 J:1];
    [actualAnswer setValue: 6  atI:1 J:2];
    [actualAnswer setValue:-48 atI:2 J:0];
    [actualAnswer setValue:-21 atI:2 J:1];
    [actualAnswer setValue: 6  atI:2 J:2];
    
    SRMatrix *matrix3 = [matrix1 multiply:matrix2];
    
    for(int i=0; i<3; i++) {
        for (int j=0; j<3; j++) {
            XCTAssertEqual([actualAnswer valueAtI:i J:j], [matrix3 valueAtI:i J:j]);
        }
    }
}

@end
