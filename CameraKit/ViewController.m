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

@property (strong, nonatomic) NSArray *focalLength, *distanceToSubject;
@property (strong, nonatomic) NSMutableArray *aperture;

@end

@implementation ViewController

@synthesize selectedCamera;
@synthesize cocValue;
@synthesize camera, totalDepthOfField, nearDistance, farDistance;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dofCalc = [[DOFCalculator alloc] init];
    
    if ([self selectedCamera] != nil)
    {
        camera.text = selectedCamera;
    }
    
    _focalLength = [[NSArray alloc]initWithObjects:@"50m", nil];
    
    _aperture = [[NSMutableArray alloc]init];
    for (Aperture *aperture in [Aperture apertureLibrary])
    {
        [_aperture addObject:[aperture fNumber]];
    }
    
    _distanceToSubject = [[NSArray alloc] initWithObjects:@"1", @"1.5", @"2", @"2.5", @"10", nil];
    
    // TODO: Look at defaulting picker selections on load, and retaining across transitions.
    // TODO: Remember the camera selection across application lifecycle.

    // NASTY_STEP1 [self performSelector:@selector(hideNavBar) withObject:nil afterDelay:0.0];
}

/* NASTY_STEP2
-(void) hideNavBar {
    if (self.navigationController.navigationBar.hidden == NO)
    {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
}
*/

// hide the navigation bar, so it does not appear on the root page
- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

// THIS: could be done in the navigation controller delegate depending on the current view controller
//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    [navigationController setNavigationBarHidden:YES animated:animated];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)calculate:(id)sender
{
    // TODO: Add a check to ensure that a camera has been selected and we have value for coc.
    
    NSString *selectFocalLength = [_focalLength objectAtIndex:[_picker selectedRowInComponent:0]];
    NSString *selectFNumber = [_aperture objectAtIndex:[_picker selectedRowInComponent:1]];
    NSString *selectDistance = [_distanceToSubject objectAtIndex:[_picker selectedRowInComponent:2]];
    
    double hfd = [_dofCalc hyperfocalDistanceForFocalLength:[selectFocalLength doubleValue] aperture:[NSNumber numberWithDouble:[selectFNumber doubleValue]] circleOfConfusion:cocValue];
    double nd = [_dofCalc nearDistanceFocalLength:[selectFocalLength doubleValue] hyperfocalDistance:hfd focusDistance:[selectDistance doubleValue]];
    double fd = [_dofCalc farDistanceForFocalLength:[selectFocalLength doubleValue] hyperfocalDistance:hfd focusDistance:[selectDistance doubleValue]];
    double tdof = [_dofCalc totalDepthOfFieldForFarDistance:fd nearDistance:nd];

    totalDepthOfField.text = [NSString stringWithFormat:@"%5.2f m", tdof];
    nearDistance.text = [NSString stringWithFormat:@"%5.2f m", nd];
    farDistance.text = [NSString stringWithFormat:@"%5.2f m", fd];
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
        return [_aperture count];
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
            return [NSString stringWithFormat:@"f/%@", [_aperture objectAtIndex:row]];
        case 2:
            return [NSString stringWithFormat:@"%@ m", [_distanceToSubject objectAtIndex:row]];
        default:
            return 0;
    }
}

@end
