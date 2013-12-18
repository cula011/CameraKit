//
//  ViewController.h
//  CameraKit
//
//  Created by Luka Kruscic on 29/11/2013.
//  Copyright (c) 2013 Luka Kruscic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DOFCalculatorViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) IBOutlet UILabel *camera;
@property (strong, nonatomic) IBOutlet UIPickerView *picker;

@property (strong, nonatomic) IBOutlet UILabel *nearDistance;
@property (strong, nonatomic) IBOutlet UILabel *farDistance;
@property (strong, nonatomic) IBOutlet UILabel *totalDepthOfField;
@property (strong, nonatomic) IBOutlet UILabel *hyperfocalDistance;

@property (strong, nonatomic) IBOutlet UISegmentedControl *metricsControl;
- (IBAction)metricsChanged:(id)sender;

@end
