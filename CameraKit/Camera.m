//
//  CameraModel.m
//  DOFCalculator
//
//  Created by Luka Kruscic on 5/12/2013.
//  Copyright (c) 2013 Luka Kruscic. All rights reserved.
//

#import "Camera.h"

@implementation Camera

@synthesize brandName, modelName;
@synthesize cocValue;

// http://en.wikipedia.org/wiki/Circle_of_confusion#Circle_of_confusion_diameter_limit_based_on_d.2F1500
+(NSDictionary*)cameraLibrary
{
    static NSDictionary *cameraLibrary = nil;
    static NSOrderedSet *canon = nil;
    
    // TODO: Investigate how to load from a plist file or something similar!
    if (canon == nil)
    {
        canon = [NSOrderedSet orderedSetWithObjects:
                 [[Camera alloc]initWithBrandName:@"Canon" modelName:@"1D Mark IV" cocValue:[NSNumber numberWithDouble:0.023]],
                 [[Camera alloc]initWithBrandName:@"Canon" modelName:@"1D X" cocValue:[NSNumber numberWithDouble:0.030]],
                 [[Camera alloc]initWithBrandName:@"Canon" modelName:@"5D Mark III" cocValue:[NSNumber numberWithDouble:0.030]],
                 [[Camera alloc]initWithBrandName:@"Canon" modelName:@"6D" cocValue:[NSNumber numberWithDouble:0.030]],
                 [[Camera alloc]initWithBrandName:@"Canon" modelName:@"7D" cocValue:[NSNumber numberWithDouble:0.019]],
                 [[Camera alloc]initWithBrandName:@"Canon" modelName:@"550D" cocValue:[NSNumber numberWithDouble:0.019]],
                 nil];
    }
    
    if (cameraLibrary == nil)
    {
        cameraLibrary = [NSDictionary dictionaryWithObjectsAndKeys:
                         canon, @"Canon",
                         nil];
    }
    return cameraLibrary;
}

-(Camera *)initWithBrandName:(NSString *)brand modelName:(NSString *)model cocValue:(NSNumber *)coc
{
    self = [super init];
    
    if (self)
    {
        [self setBrandName:brand];
        [self setModelName:model];
        [self setCocValue:coc];
    }
    
    return self;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@ %@", brandName, modelName];
}

@end
