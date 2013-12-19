//
//  CameraTests.m
//  CameraKit
//
//  Created by Luka Kruscic on 19/12/2013.
//  Copyright (c) 2013 Luka Kruscic. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Camera.h"

@interface CameraTests : XCTestCase

@end

@implementation CameraTests

- (void)testBrands
{
    NSArray *brands = [Camera brands];
    XCTAssertTrue(brands != nil, @"Camera class should return the set of brands present in the plist file.");
    XCTAssertTrue([brands count] == 9, @"Expected 9 brands, but found %lu", (unsigned long)[brands count]);
    XCTAssertTrue([brands containsObject:@"Canon"], @"Canon could not be found in the list of brands");
}

-(void)testModels
{
    NSArray *models = [Camera modelsFor:@"Canon"];
    XCTAssertTrue(models != nil, @"Camera class should return the set of models for Canon present in the plist file.");
    XCTAssertTrue([models count] > 130, @"Expected more than 130 brands, but found %lu", (unsigned long)[models count]);
    Camera *sample = [models objectAtIndex:0];
    XCTAssert(sample.brandName != nil && sample.modelName != nil && sample.cocValue != nil,
              @"Sample camera should have non nil values for brandName [%@], modelName [%@] and cocValue [%f].",
              sample.brandName, sample.modelName, [sample.cocValue doubleValue]);
}

@end
