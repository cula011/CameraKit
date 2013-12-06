//
//  DOFCalculator.h
//  DOFCalculator
//
//  Created by Luka Kruscic on 25/11/2013.
//  Copyright (c) 2013 Luka Kruscic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DOFCalculator : NSObject

// assuming the focal length is provided in millimeters, return the hyperfocal distance in meters
-(double)hyperfocalDistanceForFocalLength:(double)fl aperture:(NSNumber*)f circleOfConfusion: (NSNumber*)coc;

-(double)nearDistanceFocalLength:(double)fl hyperfocalDistance:(double)hd focusDistance:(double)fd;

-(double)farDistanceForFocalLength:(double)fl hyperfocalDistance:(double)hd focusDistance:(double)fd;

-(double)distanceInFrontOfSubjectForFocusDistance:(double)focus nearDistance:(double)near;

-(double)distanceBehindSubjectForFocusDistance:(double)focus farDistance:(double)far;

-(double)totalDepthOfFieldForFarDistance:(double)far nearDistance: (double)near;

@end