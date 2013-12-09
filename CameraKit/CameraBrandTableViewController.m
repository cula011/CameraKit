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

@property (strong, nonatomic) NSArray *brands;
@property (strong, nonatomic) NSMutableArray *brandSearch;

@end

@implementation CameraBrandTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _brands = [[NSArray alloc] initWithArray:[[Camera cameraLibrary] allKeys]];
    
    _brandSearch = [[NSMutableArray alloc] initWithCapacity:[_brands count]];
    

    // Hide the search bar until user scrolls up
    CGRect newBounds = self.tableView.bounds;
    newBounds.origin.y = newBounds.origin.y + self.searchDisplayController.searchBar.bounds.size.height;
    self.tableView.bounds = newBounds;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

// http://stackoverflow.com/a/18903533
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar.layer removeAllAnimations];
}
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [self.navigationController setNavigationBarHidden:NO animated:animated];
//    [super viewWillDisappear:animated];
//}

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

#pragma mark Content Filtering
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    [_brandSearch removeAllObjects];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", searchText];
    _brandSearch = [NSMutableArray arrayWithArray:[_brands filteredArrayUsingPredicate:predicate]];
}

#pragma mark - UISearchDisplayController Delegate Methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    
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
        return [_brandSearch count];
    }
    else
    {
        return [_brands count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CameraBrandCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath]; // TODO: Why did using 'self.tableView' instead of tableView fix everything?!
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        cell.textLabel.text = [_brandSearch objectAtIndex:indexPath.row];
    } else
    {
        cell.textLabel.text = [_brands objectAtIndex:indexPath.row];
    }
    
    return cell;
}

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    CameraModelTableViewController *destViewController = [segue destinationViewController];
    if (self.searchDisplayController.active)
    {
        destViewController.brandName = [_brandSearch objectAtIndex:indexPath.row];
    }
    else
    {
        destViewController.brandName = [_brands objectAtIndex:indexPath.row];
    }
    //if ([segue.identifier isEqualToString:@"showCameraModel"]) {
}

@end
