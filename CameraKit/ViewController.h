//
//  ViewController.h
//  CameraKit
//
//  Created by Luka Kruscic on 29/11/2013.
//  Copyright (c) 2013 Luka Kruscic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) NSString *selectedCamera;
@property (strong, nonatomic) NSNumber *cocValue;

@property (strong, nonatomic) IBOutlet UILabel *camera;
@property (strong, nonatomic) IBOutlet UIPickerView *picker;

- (IBAction)calculate:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *nearDistance;
@property (strong, nonatomic) IBOutlet UILabel *farDistance;
@property (strong, nonatomic) IBOutlet UILabel *totalDepthOfField;
@property (strong, nonatomic) IBOutlet UILabel *hyperfocalDistance;

@end
