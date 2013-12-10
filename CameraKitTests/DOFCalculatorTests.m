//
//  DOFCalculatorTests.m
//  DOFCalculatorTests
//
//  Created by Luka Kruscic on 25/11/2013.
//  Copyright (c) 2013 Luka Kruscic. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "DOFCalculator.h"

@interface DOFCalculatorTests : XCTestCase
{
@private
    DOFCalculator *dofCalc;
}

@end

@implementation DOFCalculatorTests

- (void)setUp
{
    [super setUp];
    dofCalc = [[DOFCalculator alloc] init];
}

- (void)tearDown
{
    dofCalc = nil;
    [super tearDown];
}

- (void)testHyperfocalDistanceCalculatorInMeters
{
    double actual = [dofCalc hyperfocalDistanceForFocalLength:50 aperture:[NSNumber numberWithDouble:2] circleOfConfusion:[NSNumber numberWithDouble:0.030] in:Meteres];
    NSString *roundedActual = [NSString stringWithFormat:@"%5.2f", actual];
    XCTAssertTrue([roundedActual isEqualToString:@"41.72"],
                  @"Hyperfocal distance should be 41.72 but was %@.", roundedActual);
}

- (void)testHyperfocalDistanceCalculatorInFeet
{
    double actual = [dofCalc hyperfocalDistanceForFocalLength:50 aperture:[NSNumber numberWithDouble:2] circleOfConfusion:[NSNumber numberWithDouble:0.030] in:Feet];
    NSString *roundedActual = [NSString stringWithFormat:@"%4.1f", actual];
    XCTAssertTrue([roundedActual isEqualToString:@"136.9"],
                  @"Hyperfocal distance should be 136.9 but was %@.", roundedActual);
}

- (void)testNearDistanceCalculatorInMeters
{
    double actual = [dofCalc nearDistanceFocalLength:50 hyperfocalDistance:41.7 focusDistance:10 in:Meteres];
    NSString *roundedActual = [NSString stringWithFormat:@"%3.2f", actual];
    XCTAssertTrue([roundedActual isEqualToString:@"8.07"],
                  @"Near distance should be 8.07 but was %@.", roundedActual);
}

- (void)testNearDistanceCalculatorInFeet
{
    double actual = [dofCalc nearDistanceFocalLength:50 hyperfocalDistance:136.9 focusDistance:10 in:Feet];
    NSString *roundedActual = [NSString stringWithFormat:@"%3.2f", actual];
    XCTAssertTrue([roundedActual isEqualToString:@"9.33"],
                  @"Near distance should be 9.33 but was %@.", roundedActual);
}

- (void)testFarDistanceCalculatorInMeters
{
    double actual = [dofCalc farDistanceForFocalLength:50 hyperfocalDistance:41.7 focusDistance:10 in:Meteres];
    NSString *roundedActual = [NSString stringWithFormat:@"%4.2f", actual];
    XCTAssertTrue([roundedActual isEqualToString:@"13.14"],
                  @"Far distance should be 13.14 but was %@.", roundedActual);
}

- (void)testFarDistanceCalculatorInFeet
{
    double actual = [dofCalc farDistanceForFocalLength:50 hyperfocalDistance:136.9 focusDistance:10 in:Feet];
    NSString *roundedActual = [NSString stringWithFormat:@"%3.1f", actual];
    XCTAssertTrue([roundedActual isEqualToString:@"10.8"],
                  @"Far distance should be 10.8 but was %@.", roundedActual);
}

-(void)testInFrontOfSubjectCalculation
{
    double actual = [dofCalc distanceInFrontOfSubjectForFocusDistance:10 nearDistance:8.07];
    NSString *roundedActual = [NSString stringWithFormat:@"%3.2f", actual];
    XCTAssertTrue([roundedActual isEqualToString:@"1.93"],
                  @"Distance in front of subject should be 1.93 but was %@.", roundedActual);
}

-(void)testBehindSubjectCalculation
{
    double actual = [dofCalc distanceBehindSubjectForFocusDistance:10 farDistance:13.1];
    NSString *roundedActual = [NSString stringWithFormat:@"%3.2f", actual];
    XCTAssertTrue([roundedActual isEqualToString:@"3.10"],
                  @"Distance behind subject should be 3.10 but was %@.", roundedActual);
}

-(void)testTotalDepthOfFieldCalculation
{
    double actual = [dofCalc totalDepthOfFieldForFarDistance:13.0 nearDistance:8.07];
    NSString *roundedActual = [NSString stringWithFormat:@"%3.2f", actual];
    XCTAssertTrue([roundedActual isEqualToString:@"4.93"],
                  @"Distance behind subject should be 4.93 but was %@.", roundedActual);
}

@end