//
//  CameraModel.h
//  DOFCalculator
//
//  Created by Luka Kruscic on 5/12/2013.
//  Copyright (c) 2013 Luka Kruscic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Camera : NSObject

@property NSString *brandName, *modelName;
@property NSNumber *cocValue;

+(NSArray *)brands;

+(NSArray *)modelsFor:(NSString *)brand;

@end
