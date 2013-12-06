//
//  Aperture.m
//  DOFCalculator
//
//  Created by Luka Kruscic on 6/12/2013.
//  Copyright (c) 2013 Luka Kruscic. All rights reserved.
//

#import "Aperture.h"

@implementation Aperture

@synthesize fNumber;
@synthesize apertureValue;

// http://en.wikipedia.org/wiki/F-number#Standard_full-stop_f-number_scale
+(NSOrderedSet*)apertureLibrary
{
    static NSOrderedSet *aperture = nil;
    
    if (aperture == nil)
    {
        aperture = [NSOrderedSet orderedSetWithObjects:
                    [[Aperture alloc] initWithFNumber:[NSNumber numberWithDouble: 1.4] apertureValue:1],
                    [[Aperture alloc] initWithFNumber:[NSNumber numberWithDouble: 2] apertureValue:2],
                    [[Aperture alloc] initWithFNumber:[NSNumber numberWithDouble: 2.8] apertureValue:3],
                    [[Aperture alloc] initWithFNumber:[NSNumber numberWithDouble: 4] apertureValue:4],
                    [[Aperture alloc] initWithFNumber:[NSNumber numberWithDouble: 5.6] apertureValue:5],
                    [[Aperture alloc] initWithFNumber:[NSNumber numberWithDouble: 8] apertureValue:6],
                    [[Aperture alloc] initWithFNumber:[NSNumber numberWithDouble: 11] apertureValue:7],
                    [[Aperture alloc] initWithFNumber:[NSNumber numberWithDouble: 16] apertureValue:8],
                    [[Aperture alloc] initWithFNumber:[NSNumber numberWithDouble: 22] apertureValue:9],
                    [[Aperture alloc] initWithFNumber:[NSNumber numberWithDouble: 32] apertureValue:10],
                    [[Aperture alloc] initWithFNumber:[NSNumber numberWithDouble: 45] apertureValue:11],
                    [[Aperture alloc] initWithFNumber:[NSNumber numberWithDouble: 64] apertureValue:12],
                    [[Aperture alloc] initWithFNumber:[NSNumber numberWithDouble: 90] apertureValue:13],
                    [[Aperture alloc] initWithFNumber:[NSNumber numberWithDouble: 128] apertureValue:14],
                    [[Aperture alloc] initWithFNumber:[NSNumber numberWithDouble: 180] apertureValue:15],
                    [[Aperture alloc] initWithFNumber:[NSNumber numberWithDouble: 256] apertureValue:16],
                    nil];
    }
    return aperture;
}

-(Aperture *)initWithFNumber:(NSNumber *)fn apertureValue:(int)av
{
    self = [super init];
    
    if (self)
    {
        [self setFNumber:fn];
        [self setApertureValue:av];
    }
    
    return self;
}

@end
