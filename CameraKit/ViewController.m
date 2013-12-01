//
//  ViewController.m
//  CameraKit
//
//  Created by Luka Kruscic on 29/11/2013.
//  Copyright (c) 2013 Luka Kruscic. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSArray *fNumber, *imageFormat;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSArray *fNumberData = [[NSArray alloc] initWithObjects:@"1.4", @"2", @"2.8", @"4", @"5.6", @"8", @"11", @"16", @"22", nil];
    self.fNumber = fNumberData;
    
    NSArray *imageFormatData = [[NSArray alloc] initWithObjects:@"Full Frame", @"APS-C", nil];
    self.imageFormat = imageFormatData;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)calculate:(id)sender
{
    NSString *selectFNumber = [_fNumber objectAtIndex:[_picker selectedRowInComponent:0]];
    NSString *selectImageFormat = [_imageFormat objectAtIndex:[_picker selectedRowInComponent:1]];
    NSString *fNumberMsg = [[NSString alloc] initWithFormat:@"You selected f-number %@ and image format %@", selectFNumber, selectImageFormat];
    UIAlertView *fNumberAlert = [[UIAlertView alloc]initWithTitle:@"Picker Selections" message:fNumberMsg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [fNumberAlert show];
}

#pragma mark Picker Data Source Methods

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0)
    {
        return [_fNumber count];
    }
    else
    {
        return [_imageFormat count];
    }
}

#pragma mark Picker Delegate Methods

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0)
    {
        return [_fNumber objectAtIndex:row];
    }
    else
    {
        return [_imageFormat objectAtIndex:row];
    }
}

@end