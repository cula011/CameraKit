//
//  DOFCalculator.m
//  DOFCalculator
//
//  Created by Luka Kruscic on 25/11/2013.
//  Copyright (c) 2013 Luka Kruscic. All rights reserved.
//

#import "DOFCalculator.h"

@implementation DOFCalculator

// circle of confusion to image sensor size mapping
// http://en.wikipedia.org/wiki/Circle_of_confusion#Circle_of_confusion_diameter_limit_based_on_d.2F1500
+(NSDictionary*)coc
{
    static NSDictionary *coc = nil;
    
    if (coc == nil)
    {
        coc = [NSDictionary dictionaryWithObjectsAndKeys:
               [NSNumber numberWithDouble:0.029], @"35 mm",
               [NSNumber numberWithDouble:0.018], @"APS-C", // Canon
               //[NSNumber numberWithDouble:0.019], @"APS-C", // Nikon/Pentax/Sony
               [NSNumber numberWithDouble:0.023], @"APS-H", // Canon
               [NSNumber numberWithDouble:0.015], @"4/3", //Four Thirds System
               [NSNumber numberWithDouble:0.011], @"Nikon 1 Series",
               nil];
    }
    return coc;
}

-(NSArray*)imageFormat
{
    return [[DOFCalculator coc] keysSortedByValueUsingComparator:
            ^(id obj1, id obj2) {
                return [obj1 compare: obj2];
            }];
}

// aperture value to f-number mapping
// http://en.wikipedia.org/wiki/F-number#Standard_full-stop_f-number_scale
+(NSDictionary*)aperture
{
    static NSDictionary *aperture = nil;
    
    if (aperture == nil)
    {
        aperture = [NSDictionary dictionaryWithObjectsAndKeys:
                    [NSNumber numberWithDouble:1], @"1.4",
                    [NSNumber numberWithDouble:2], @"2",
                    [NSNumber numberWithDouble:3], @"2.8",
                    [NSNumber numberWithDouble:4], @"4",
                    [NSNumber numberWithDouble:5], @"5.6",
                    [NSNumber numberWithDouble:6], @"8",
                    [NSNumber numberWithDouble:7], @"11",
                    [NSNumber numberWithDouble:8], @"16",
                    [NSNumber numberWithDouble:9], @"22",
                    nil];
    }
    return aperture;
}

-(NSArray*)fNumber
{
    return [[DOFCalculator aperture] keysSortedByValueUsingComparator:
            ^(id obj1, id obj2) {
                return [obj1 compare: obj2];
            }];
}

-(double)hyperfocalDistanceForFocalLength:(double)fl fNumber:(NSString*)f imageFormat: (NSString*) imageFormat;
{
    NSNumber *apertureValue = [[DOFCalculator aperture] objectForKey:f];
    double fnumber = pow(2, [apertureValue doubleValue] / 2);
    NSNumber *cocValue = [[DOFCalculator coc] objectForKey:imageFormat];
    double hd = (fl * fl) / (fnumber * [cocValue doubleValue]) + fl;
    return hd/1000;
}

-(double)nearDistanceForFocusDistance:(double)fd hyperfocalDistance:(double)hd focalLength: (double) fl
{
    double dn = (fd*1000 * (hd*1000 - fl)) / (hd*1000 + fd*1000 - 2 * fl);
    return dn/1000;
}

-(double)farDistanceForFocusDistance:(double)fd hyperfocalDistance:(double)hd focalLength: (double) fl
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