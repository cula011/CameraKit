//
//  ApertureTests.m
//  CameraKit
//
//  Created by Luka Kruscic on 19/12/2013.
//  Copyright (c) 2013 Luka Kruscic. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Aperture.h"

@interface ApertureTests : XCTestCase

@end

@implementation ApertureTests

- (void)testExample
{
    NSOrderedSet *apertures = [Aperture apertureLibrary];
    XCTAssertTrue(apertures != nil, @"Aperture class should return an ordered set of Aperture objects.");
    XCTAssertTrue([apertures count] == 16, @"Expected 16 Aperture objects, but found %lu", (unsigned long)[apertures count]);
    Aperture *sample = [apertures objectAtIndex:4];
    XCTAssertTrue([sample.fNumber compare:[NSNumber numberWithDouble:5.6]] == NSOrderedSame,
                  @"Exected an f-number value of 5.6, but found %f.", [sample.fNumber doubleValue]);
    XCTAssertEqual(sample.apertureValue, 5, @"Exected aperture value of 5, but found %d.", sample.apertureValue);
}

@end
