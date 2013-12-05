//
//  DOFCalculator.h
//  DOFCalculator
//
//  Created by Luka Kruscic on 25/11/2013.
//  Copyright (c) 2013 Luka Kruscic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DOFCalculator : NSObject

-(NSArray *)imageFormat;
-(NSArray *)fNumber;

//typedef NS_ENUM(NSInteger, ImageFormat) {
//    Full_Frame
//};
//
//// aperture value to f-number mapping
//// http://en.wikipedia.org/wiki/F-number#Standard_full-stop_f-number_scale
//typedef NS_ENUM(NSInteger, FNumber) {
//    One_Point_Four = 1,
//    Two,
//    Two_Point_Eight,
//    Four,
//    Five_Point_Six,
//    Eight,
//    Eleven,
//    Sixteen,
//    TwentyTwo
//};

// assuming the focal length is provided in millimeters, return the hyperfocal distance in meters
-(double)hyperfocalDistanceForFocalLength:(double)fl fNumber:(NSString*)f imageFormat: (NSString*) imageFormat;

-(double)nearDistanceForFocusDistance:(double)fs hyperfocalDistance:(double)hd focalLength:(double)fl;

-(double)farDistanceForFocusDistance:(double)fs hyperfocalDistance:(double)hd focalLength:(double)fl;

-(double)distanceInFrontOfSubjectForFocusDistance:(double)focus nearDistance:(double)near;

-(double)distanceBehindSubjectForFocusDistance:(double)focus farDistance:(double)far;

-(double)totalDepthOfFieldForFarDistance:(double)far nearDistance: (double)near;

@end