//
//  CameraModelTableViewController.m
//  CameraKit
//
//  Created by Luka Kruscic on 4/12/2013.
//  Copyright (c) 2013 Luka Kruscic. All rights reserved.
//

#import "CameraModelTableViewController.h"
#import "ViewController.h"

@interface CameraModelTableViewController ()

@property (strong, nonatomic) NSArray *models;
@property (strong, nonatomic) NSNumber *cocValue;

@end

@implementation CameraModelTableViewController

@synthesize brandName;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // TODO: The model set should be derived from the incoming camera branc.
    _models = [NSArray arrayWithObjects:@"700D", @"70D", @"7D", @"6D", @"5D Mark III", @"1D", nil];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //cell.accessoryType = UITableViewCellAccessoryCheckmark;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_models count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CameraModelCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [_models objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // TODO: Retrieve the camera brand and model name, so that it can be dispayed on the main screen for the user's reference.
    // TODO: Retrieve the CoC value for the selected camera, so that can be passed back to main controller for calculation.
    
    if ([segue.identifier isEqualToString:@"showMainScene"]) {
        ViewController *destViewController = segue.destinationViewController;
        destViewController.cocValue = _cocValue;
    }
}

@end