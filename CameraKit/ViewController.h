//
//  ViewController.h
//  CameraKit
//
//  Created by Luka Kruscic on 29/11/2013.
//  Copyright (c) 2013 Luka Kruscic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *picker;

@property (strong, nonatomic) IBOutlet UITextField *distanceToSubject;

@property (strong, nonatomic) IBOutlet UILabel *totalDepthOfField;
@property (strong, nonatomic) IBOutlet UILabel *nearDistance;
@property (strong, nonatomic) IBOutlet UILabel *farDistance;

@property (strong, nonatomic) NSNumber *cocValue;

- (IBAction)calculate:(id)sender;
- (IBAction)swipeDownToCloseKeyboard:(UISwipeGestureRecognizer *)sender;

@end