//
//  DOFCalculator.m
//  DOFCalculator
//
//  Created by Luka Kruscic on 25/11/2013.
//  Copyright (c) 2013 Luka Kruscic. All rights reserved.
//

#import "DOFCalculator.h"
#import "Camera.h"
#import "Aperture.h"

@implementation DOFCalculator

-(double)hyperfocalDistanceForFocalLength:(double)fl aperture:(NSNumber*)a circleOfConfusion:(NSNumber*) coc in:(Units) m;
{
    double fnumber = pow(2, [a doubleValue] / 2);
    double hd = (fl * fl) / (fnumber * [coc doubleValue]) + fl;
    return hd / [self divisorForMetric:m];
}

-(double)nearDistanceFocalLength:(double)fl hyperfocalDistance:(double)hd focusDistance:(double)fd in:(Units) m
{
    double divisor = [self divisorForMetric:m];
    double dn = (fd*divisor * (hd*divisor - fl)) / (hd*divisor + fd*divisor - 2 * fl);
    return dn/divisor;
}

-(double)farDistanceForFocalLength:(double)fl hyperfocalDistance:(double)hd focusDistance:(double)fd in:(Units) m
{
    double divisor = [self divisorForMetric:m];
    double dr = (fd*divisor * (hd*divisor - fl)) / (hd*divisor - fd*divisor);
    return dr/divisor;
}

-(double)distanceInFrontOfSubjectForFocusDistance:(double)focus nearDistance: (double) near
{
    return focus - near;
}

-(double)distanceBehindSubjectForFocusDistance:(double)focus farDistance: (double) far
{
    return far - focus;
}

- (double)totalDepthOfFieldForFarDistance:(double)far nearDistance: (double)near
{
    return far - near;
}

-(double)divisorForMetric:(Units)m
{
    switch (m) {
        case Meteres:
            return 1000;
        case Feet:
            return 304.8;
    }
}

@end
