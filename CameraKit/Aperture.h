//
//  Aperture.h
//  DOFCalculator
//
//  Created by Luka Kruscic on 6/12/2013.
//  Copyright (c) 2013 Luka Kruscic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Aperture : NSObject

@property (strong, atomic) NSNumber *fNumber;
@property int apertureValue;

+(NSOrderedSet*)apertureLibrary;

@end
