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

-(double)hyperfocalDistanceForFocalLength:(double)fl aperture:(NSNumber*)a circleOfConfusion:(NSNumber*) coc;
{
    double fnumber = pow(2, [a doubleValue] / 2);
    double hd = (fl * fl) / (fnumber * [coc doubleValue]) + fl;
    return hd/1000;
}

-(double)nearDistanceFocalLength:(double)fl hyperfocalDistance:(double)hd focusDistance:(double)fd
{
    double dn = (fd*1000 * (hd*1000 - fl)) / (hd*1000 + fd*1000 - 2 * fl);
    return dn/1000;
}

-(double)farDistanceForFocalLength:(double)fl hyperfocalDistance:(double)hd focusDistance:(double)fd
{
    double dr = (fd*1000 * (hd*1000 - fl)) / (hd*1000 - fd*1000);
    return dr/1000;
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

@end