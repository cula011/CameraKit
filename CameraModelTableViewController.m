//
//  CameraModelTableViewController.m
//  CameraKit
//
//  Created by Luka Kruscic on 4/12/2013.
//  Copyright (c) 2013 Luka Kruscic. All rights reserved.
//

#import "CameraModelTableViewController.h"
#import "Camera.h"

@interface CameraModelTableViewController () <UISearchDisplayDelegate>

@property (strong, nonatomic) NSArray *models;
@property (strong, nonatomic) NSMutableArray *modelSearch;

@end

@implementation CameraModelTableViewController

@synthesize brandName;

#pragma mark - UIViewController lifecycle methods

- (void)viewDidLoad
{
    [super viewDidLoad];

    _models = [NSArray arrayWithArray:[Camera modelsFor:brandName]];

    _modelSearch = [NSMutableArray arrayWithCapacity:[_models count]];
    
    [[self navigationItem] setTitle:brandName];
    
    // Hide the search bar until user scrolls up
    CGRect newBounds = self.tableView.bounds;
    newBounds.origin.y = newBounds.origin.y + self.searchDisplayController.searchBar.bounds.size.height;
    self.tableView.bounds = newBounds;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Content Filtering

-(void)filterContentForSearchString:(NSString*)searchString
{
    [_modelSearch removeAllObjects];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.modelName contains[search] %@", searchString];
    _modelSearch = [NSMutableArray arrayWithArray:[_models filteredArrayUsingPredicate:predicate]];
}

#pragma mark - UISearchDisplayDelegate methods

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchString:searchString];
    
    return YES;
}

#pragma mark - UITableViewDelegate methods

// Store the selection, so it can be maintained across restarts.
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *selectedCocValue;
    NSString *selectedCameraModel;
    
    if ([self.searchDisplayController isActive])
    {
        selectedCocValue = [[_modelSearch objectAtIndex:indexPath.row] cocValue];
        selectedCameraModel = [NSString stringWithFormat:@"%@ %@",
                               [[_modelSearch objectAtIndex:indexPath.row] brandName],
                               [[_modelSearch objectAtIndex:indexPath.row] modelName]];
    }
    else
    {
        selectedCocValue = [[[Camera modelsFor:brandName] objectAtIndex:indexPath.row] cocValue];
        selectedCameraModel = [NSString stringWithFormat:@"%@ %@",
                               [[_models objectAtIndex:indexPath.row] brandName],
                               [[_models objectAtIndex:indexPath.row] modelName]];
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:selectedCameraModel forKey:@"selectedCameraModel"];
    [userDefaults setValue:selectedCocValue forKey:@"cocValue"];
    
    return indexPath;
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView == self.tableView)
    {
        return [_models count];
    }
    else
    {
        return [_modelSearch count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CameraModelCell";
    // https://developer.apple.com/Library/ios/documentation/UserExperience/Conceptual/TableView_iPhone/CreateConfigureTableView/CreateConfigureTableView.html#//apple_ref/doc/uid/TP40007451-CH6-SW5
    // re: self.tableView http://useyourloaf.com/blog/2012/09/06/search-bar-table-view-storyboard.html    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (tableView == self.tableView)
    {
        cell.textLabel.text = [[_models objectAtIndex:indexPath.row] modelName];
    } else {
        cell.textLabel.text = [[_modelSearch objectAtIndex:indexPath.row] modelName];
    }
    
    return cell;
}

@end
