//
//  CameraTableViewController.m
//  CameraKit
//
//  Created by Luka Kruscic on 4/12/2013.
//  Copyright (c) 2013 Luka Kruscic. All rights reserved.
//

#import "CameraBrandTableViewController.h"
#import "CameraModelTableViewController.h"
#import "Camera.h"

@interface CameraBrandTableViewController ()

@property (strong, nonatomic) NSArray *cameraType;
@property (strong, nonatomic) NSMutableArray *brandSearch;

@end

@implementation CameraBrandTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _cameraType = [[NSArray alloc] initWithArray:[[Camera cameraLibrary] allKeys]];
    
    _brandSearch = [[NSMutableArray alloc] initWithCapacity:[_cameraType count]];
    

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
    // UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    // cell.accessoryType = UITableViewCellAccessoryCheckmark;
}

//===========

#pragma mark Content Filtering
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    [_brandSearch removeAllObjects];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@", searchText];
    _brandSearch = [NSMutableArray arrayWithArray:[_cameraType filteredArrayUsingPredicate:predicate]];
}

#pragma mark - UISearchDisplayController Delegate Methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    return YES;
}

//===========

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return [_brandSearch count];
    }
    else
    {
        return [_cameraType count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CameraBrandCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    //if (cell == nil) {
    //    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    //}
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text = [_brandSearch objectAtIndex:indexPath.row];
    } else {
        cell.textLabel.text = [_cameraType objectAtIndex:indexPath.row];
    }
    
    return cell;
}

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"showCameraModel"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        CameraModelTableViewController *destViewController = segue.destinationViewController;
        destViewController.brandName = [_cameraType objectAtIndex:indexPath.row];
    }
    
}

@end
