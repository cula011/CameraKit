//
//  CameraModelTableViewController.m
//  CameraKit
//
//  Created by Luka Kruscic on 4/12/2013.
//  Copyright (c) 2013 Luka Kruscic. All rights reserved.
//

#import "CameraModelTableViewController.h"
#import "ViewController.h"
#import "Camera.h"

@interface CameraModelTableViewController ()

@property (strong, nonatomic) NSMutableArray *models;
@property (strong, nonatomic) NSMutableArray *modelSearch;

@end

@implementation CameraModelTableViewController

@synthesize brandName;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _models = [[NSMutableArray alloc] init];
    for (Camera *camera in [[Camera cameraLibrary] objectForKey:brandName])
    {
        [_models addObject:[NSString stringWithFormat:@"%@", camera]];
    }
    
    _modelSearch = [[NSMutableArray alloc] initWithCapacity:[_models count]];
    
    // Hide the search bar until user scrolls up
    CGRect newBounds = self.tableView.bounds;
    newBounds.origin.y = newBounds.origin.y + self.searchDisplayController.searchBar.bounds.size.height;
    self.tableView.bounds = newBounds;

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

#pragma mark Content Filtering
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    [_modelSearch removeAllObjects];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", searchText];
    _modelSearch = [NSMutableArray arrayWithArray:[_models filteredArrayUsingPredicate:predicate]];
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
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath]; // TODO: Why did using 'self.tableView' instead of tableView fix everything?!
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text = [_modelSearch objectAtIndex:indexPath.row];
    } else {
        cell.textLabel.text = [_models objectAtIndex:indexPath.row];
    }
    
    return cell;
}

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    ViewController *destViewController = [segue destinationViewController];
    if (self.searchDisplayController.active)
    {
        // get the location in the original array, so that we can correctly match to the original data source
        NSUInteger index = [_models indexOfObject:[_modelSearch objectAtIndex:indexPath.row]];
        destViewController.cocValue = [[[[Camera cameraLibrary] objectForKey:brandName]objectAtIndex:index] cocValue];
        destViewController.selectedCamera = [_modelSearch objectAtIndex:indexPath.row];
    }
    else
    {
        destViewController.cocValue = [[[[Camera cameraLibrary] objectForKey:brandName]objectAtIndex:indexPath.row] cocValue];
        destViewController.selectedCamera = [_models objectAtIndex:indexPath.row];
    }
    
    //if ([segue.identifier isEqualToString:@"showMainScene"]){}
}

@end
