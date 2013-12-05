//
//  ViewController.m
//  CameraKit
//
//  Created by Luka Kruscic on 29/11/2013.
//  Copyright (c) 2013 Luka Kruscic. All rights reserved.
//

#import "ViewController.h"
#import "DOFCalculator.h"

@interface ViewController ()

@property (strong, nonatomic) NSArray *focalLength, *fNumber, *imageFormat;

@property (strong, nonatomic) DOFCalculator *dofCalc;

@end

@implementation ViewController

@synthesize cocValue;

//@synthesize totalDepthOfField, nearDistance, farDistance, distanceToSubject;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dofCalc = [[DOFCalculator alloc] init];
    
    NSArray *focalLengthData = [[NSArray alloc] initWithObjects:@"50", nil];
    _focalLength = focalLengthData;
    
    _fNumber = [_dofCalc fNumber];
    
    _imageFormat = [_dofCalc imageFormat];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)calculate:(id)sender
{
    NSString *selectImageFormat = [_imageFormat objectAtIndex:[_picker selectedRowInComponent:2]];
    NSString *selectFocalLength = [_focalLength objectAtIndex:[_picker selectedRowInComponent:0]];
    NSString *selectFNumber = [_fNumber objectAtIndex:[_picker selectedRowInComponent:1]];
    
    // TODO: deal with whitespace and non numerical entries
    if ([_distanceToSubject.text length] == 0)
    {
        UIAlertView *errAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"You must provide a value for the 'Distance to Subject'" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [errAlert show];
    }
    double dist = [_distanceToSubject.text doubleValue];
    
    double hfd = [_dofCalc hyperfocalDistanceForFocalLength:[selectFocalLength doubleValue] fNumber:selectFNumber imageFormat:selectImageFormat];
    double nd = [_dofCalc nearDistanceForFocusDistance:dist hyperfocalDistance:hfd focalLength:[selectFocalLength doubleValue]];
    double fd = [_dofCalc farDistanceForFocusDistance:dist hyperfocalDistance:hfd focalLength:[selectFocalLength doubleValue]];
    double tdof = [_dofCalc totalDepthOfFieldForFarDistance:fd nearDistance:nd];

    _totalDepthOfField.text = [NSString stringWithFormat:@"%5.2f m", tdof];
    _nearDistance.text = [NSString stringWithFormat:@"%5.2f m", nd];
    _farDistance.text = [NSString stringWithFormat:@"%5.2f m", fd];
    
    if(_distanceToSubject)
    {
        [_distanceToSubject resignFirstResponder];
    }
}

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

#pragma mark UI Interactions

// close the keyboard when the 'Done' button is pressed
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

// close the keyboard when the swipe down gesture is executed
- (IBAction)swipeDownToCloseKeyboard:(UISwipeGestureRecognizer *)sender
{
    if(_distanceToSubject)
    {
        [_distanceToSubject resignFirstResponder];
    }
}

// close the keyboard when the background view is tapped
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([_distanceToSubject isFirstResponder] && [touch view] != _distanceToSubject) {
        [_distanceToSubject resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
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
        return [_imageFormat count];
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
            return [_fNumber objectAtIndex:row];
        case 2:
            return [_imageFormat objectAtIndex:row];
        default:
            return 0;
    }
}

@end