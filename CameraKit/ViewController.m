//
//  ViewController.m
//  CameraKit
//
//  Created by Luka Kruscic on 29/11/2013.
//  Copyright (c) 2013 Luka Kruscic. All rights reserved.
//

#import "ViewController.h"
#import "Aperture.h"
#import "DOFCalculator.h"

@interface ViewController ()

@property (strong, nonatomic) DOFCalculator *dofCalc;

@property (strong, nonatomic) NSString *selectedCameraModel;
@property (strong, nonatomic) NSNumber *cocValue;

@property (strong, nonatomic) NSArray *focalLength, *distanceToSubject;
@property (strong, nonatomic) NSMutableArray *fNumber;

-(void)calculate;

@end

@implementation ViewController

Units selectedMetric;

@synthesize picker;
@synthesize camera, nearDistance, farDistance, totalDepthOfField, hyperfocalDistance;
@synthesize metricsControl;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dofCalc = [[DOFCalculator alloc] init];
    
    _focalLength = [[NSArray alloc]initWithObjects:@"50m", nil];
    
    _fNumber = [[NSMutableArray alloc]init];
    for (Aperture *aperture in [Aperture apertureLibrary])
    {
        [_fNumber addObject:[aperture fNumber]];
    }
    
    _distanceToSubject = [[NSArray alloc] initWithObjects:@"1", @"1.5", @"2", @"2.5", @"10", nil];
    

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults stringForKey:@"selectedCameraModel"] != nil &&
        [userDefaults objectForKey:@"cocValue"] != nil)
    {
        _selectedCameraModel = [userDefaults stringForKey:@"selectedCameraModel"];
        _cocValue = [userDefaults objectForKey:@"cocValue"];
    }
    
    if (_selectedCameraModel != nil)
    {
        camera.text = [NSString stringWithFormat:@"%@", _selectedCameraModel];
    }
    
    [picker selectRow:[userDefaults integerForKey:@"selectedFocalLength"] inComponent:0 animated:NO];
    [picker selectRow:[userDefaults integerForKey:@"selectedFNumber"] inComponent:1 animated:NO];
    [picker selectRow:[userDefaults integerForKey:@"selectedDistance"] inComponent:2 animated:NO];
    
    selectedMetric = [userDefaults integerForKey:@"selectedMetric"];
    [metricsControl setSelectedSegmentIndex:selectedMetric];
    
    [self calculate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:[picker selectedRowInComponent:0] forKey:@"selectedFocalLength"];
    [userDefaults setInteger:[picker selectedRowInComponent:1] forKey:@"selectedFNumber"];
    [userDefaults setInteger:[picker selectedRowInComponent:2] forKey:@"selectedDistance"];

    [self calculate];
}

- (void)calculate
{
    if (_selectedCameraModel == nil || _cocValue == nil)
    {
        return;
    }
    
    NSString *selectedFocalLength = [_focalLength objectAtIndex:[picker selectedRowInComponent:0]];
    Aperture *selectedFNumber = [[Aperture apertureLibrary] objectAtIndex:[picker selectedRowInComponent:1]];
    int selectedApertureValue = [selectedFNumber apertureValue];
    NSString *selectedDistance = [_distanceToSubject objectAtIndex:[picker selectedRowInComponent:2]];
    
    double hfd = [_dofCalc hyperfocalDistanceForFocalLength:[selectedFocalLength doubleValue] aperture:[NSNumber numberWithInt:selectedApertureValue] circleOfConfusion:_cocValue in:selectedMetric];
    double nd = [_dofCalc nearDistanceFocalLength:[selectedFocalLength doubleValue] hyperfocalDistance:hfd focusDistance:[selectedDistance doubleValue] in:selectedMetric];
    double fd = [_dofCalc farDistanceForFocalLength:[selectedFocalLength doubleValue] hyperfocalDistance:hfd focusDistance:[selectedDistance doubleValue] in:selectedMetric];
    double tdof = [_dofCalc totalDepthOfFieldForFarDistance:fd nearDistance:nd];

    nearDistance.text = [NSString stringWithFormat:@"%5.2f", nd];
    if (fd < 0)
    {
        farDistance.text = @"Infinity";
        totalDepthOfField.text = @"Infinite";
    }
    else
    {
        farDistance.text = [NSString stringWithFormat:@"%5.2f", fd];
        totalDepthOfField.text = [NSString stringWithFormat:@"%5.2f", tdof];
    }
    hyperfocalDistance.text = [NSString stringWithFormat:@"%5.2f", hfd];
}

- (IBAction)metricsChanged:(id)sender
{
    selectedMetric = [sender selectedSegmentIndex];

    [self calculate];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:selectedMetric forKey:@"selectedMetric"];
}

#pragma mark Picker Data Source Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component)
    {
    case 0:
        return [_focalLength count];
    case 1:
        return [_fNumber count];
    case 2:
        return [_distanceToSubject count];
    default:
        return 0;
    }
}

#pragma mark Picker Delegate Methods

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component)
    {
        case 0:
            return [NSString stringWithFormat:@"%@ mm", [_focalLength objectAtIndex:row]];
        case 1:
            return [NSString stringWithFormat:@"f/%@", [_fNumber objectAtIndex:row]];
        case 2:
            return [_distanceToSubject objectAtIndex:row];
        default:
            return 0;
    }
}

@end
