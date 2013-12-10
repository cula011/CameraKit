//
//  DOFCalculator.h
//  DOFCalculator
//
//  Created by Luka Kruscic on 25/11/2013.
//  Copyright (c) 2013 Luka Kruscic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DOFCalculator : NSObject

typedef NS_ENUM(NSInteger, Units)
{
    Meteres,
    Feet
};

-(double)hyperfocalDistanceForFocalLength:(double)fl aperture:(NSNumber*)f circleOfConfusion: (NSNumber*)coc in:(Units) m;

-(double)nearDistanceFocalLength:(double)fl hyperfocalDistance:(double)hd focusDistance:(double)fd in:(Units) m;

-(double)farDistanceForFocalLength:(double)fl hyperfocalDistance:(double)hd focusDistance:(double)fd in:(Units) m;

-(double)distanceInFrontOfSubjectForFocusDistance:(double)focus nearDistance:(double)near;

-(double)distanceBehindSubjectForFocusDistance:(double)focus farDistance:(double)far;

-(double)totalDepthOfFieldForFarDistance:(double)far nearDistance: (double)near;

@end