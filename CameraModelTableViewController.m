//
//  CameraModelTableViewController.m
//  CameraKit
//
//  Created by Luka Kruscic on 4/12/2013.
//  Copyright (c) 2013 Luka Kruscic. All rights reserved.
//

#import "CameraModelTableViewController.h"
#import "Camera.h"

@interface CameraModelTableViewController ()

@property (strong, nonatomic) NSArray *models;
@property (strong, nonatomic) NSMutableArray *modelSearch;

@end

@implementation CameraModelTableViewController

@synthesize brandName;

- (void)viewDidLoad
{
    [super viewDidLoad];

    _models = [NSArray arrayWithArray:[Camera modelsFor:brandName]];

    _modelSearch = [NSMutableArray arrayWithCapacity:[_models count]];
    
    [[self navigationItem] setTitle:brandName];
    
    // Hide the search bar until user scrolls up
//    CGRect newBounds = self.tableView.bounds;
//    newBounds.origin.y = newBounds.origin.y + self.searchDisplayController.searchBar.bounds.size.height;
//    self.tableView.bounds = newBounds;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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

#pragma mark Content Filtering

-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    [_modelSearch removeAllObjects];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.modelName contains[cd] %@", searchText];
    _modelSearch = [NSMutableArray arrayWithArray:[_models filteredArrayUsingPredicate:predicate]];
}

#pragma mark - UISearchDisplayController Delegate Methods

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{    
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return [_modelSearch count];
    }
    else
    {
        return [_models count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CameraModelCell";
    // https://developer.apple.com/Library/ios/documentation/UserExperience/Conceptual/TableView_iPhone/CreateConfigureTableView/CreateConfigureTableView.html#//apple_ref/doc/uid/TP40007451-CH6-SW5
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        cell.textLabel.text = [[_modelSearch objectAtIndex:indexPath.row] modelName];
    } else {
        cell.textLabel.text = [[_models objectAtIndex:indexPath.row] modelName];
    }
    
    return cell;
}

//=====
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"CameraModelCell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];// forIndexPath:indexPath];
//    
//    if (cell == nil)
//    {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
//    }
//    
//    if (tableView == self.searchDisplayController.searchResultsTableView)
//    {
//        cell.textLabel.text = [[_modelSearch objectAtIndex:indexPath.row] modelName];
//    } else {
//        cell.textLabel.text = [[_models objectAtIndex:indexPath.row] modelName];
//    }
//    
//    return cell;
//}
//=====


@end
