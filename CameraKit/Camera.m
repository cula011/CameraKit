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

+(NSArray *)brands
{
    static NSArray *brands = nil;
    
    if (brands == nil)
    {
        brands = [NSArray arrayWithArray:[[Camera cameraRepository] allKeys]];
    }
    
    return brands;
}

+(NSArray *)modelsFor:(NSString *)brand
{
    NSDictionary *modelRepository = [[Camera cameraRepository] objectForKey:brand];
    
    // TODO: Model array is being re-created on each request. This should possibly be cached!
    NSMutableArray *models = [NSMutableArray arrayWithCapacity:[modelRepository count]];
    
    for (NSDictionary *model in modelRepository)
    {
        Camera *camera = [[self alloc] initWithBrandName:brand
                                               modelName:[model objectForKey:@"modelName"]
                                                cocValue:[model objectForKey:@"cocValue"]];
        [models addObject:camera];
    }
    
    return models;
}

+(NSDictionary *)cameraRepository
{
    static NSDictionary *repository = nil;
    
    if (repository == nil)
    {
        NSPropertyListFormat format;
        NSError *errorDesc = nil;
        NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                  NSUserDomainMask, YES) objectAtIndex:0];
        NSString *plistPath = [rootPath stringByAppendingPathComponent:@"CameraRepository.plist"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
        {
            plistPath = [[NSBundle mainBundle] pathForResource:@"CameraRepository" ofType:@"plist"];
        }
        NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
        
        repository = (NSDictionary *)[NSPropertyListSerialization propertyListWithData:plistXML
                                                                               options:NSPropertyListXMLFormat_v1_0
                                                                                format:&format
                                                                                 error:&errorDesc];
        if (!repository)
        {
            NSLog(@"Error reading plist: %@, format: %lu", errorDesc, format);
        }
    }
        
    return repository;
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
