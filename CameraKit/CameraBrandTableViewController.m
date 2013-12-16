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

@interface CameraBrandTableViewController () <UISearchDisplayDelegate>

@property (strong, nonatomic) NSArray *brands;
@property (strong, nonatomic) NSMutableArray *brandSearch;

@end

@implementation CameraBrandTableViewController

#pragma mark - UIViewController lifecycle methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _brands = [Camera brands];
    
    _brandSearch = [NSMutableArray arrayWithCapacity:[_brands count]];

    // Hide the search bar until user scrolls up
    CGRect newBounds = self.tableView.bounds;
    newBounds.origin.y = newBounds.origin.y + self.searchDisplayController.searchBar.bounds.size.height;
    self.tableView.bounds = newBounds;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar.layer removeAllAnimations]; //http://stackoverflow.com/a/18903533
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Content Filtering

-(void)filterContentForSearchString:(NSString*)searchString
{
    [_brandSearch removeAllObjects];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[search] %@", searchString];
    _brandSearch = [NSMutableArray arrayWithArray:[_brands filteredArrayUsingPredicate:predicate]];
}

#pragma mark - UISearchDisplayDelegate methods

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    
    [self filterContentForSearchString:searchString];
    
    return YES;
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
        return [_brands count];
    }
    else
    {
        return [_brandSearch count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CameraBrandCell";
    // https://developer.apple.com/Library/ios/documentation/UserExperience/Conceptual/TableView_iPhone/CreateConfigureTableView/CreateConfigureTableView.html#//apple_ref/doc/uid/TP40007451-CH6-SW5
    // re: self.tableView http://useyourloaf.com/blog/2012/09/06/search-bar-table-view-storyboard.html
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (tableView == self.tableView)
    {
        cell.textLabel.text = [_brands objectAtIndex:indexPath.row];
    } else
    {
        cell.textLabel.text = [_brandSearch objectAtIndex:indexPath.row];
    }
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *brandName = nil;
    NSIndexPath *indexPath = nil;
    
    if ([segue.identifier isEqualToString:@"showCameraModel"])
    {
        if ([self.searchDisplayController isActive])
        {
            indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            brandName = [_brandSearch objectAtIndex:indexPath.row];
        }
        else
        {
            indexPath = [self.tableView indexPathForSelectedRow];
            brandName = [_brands objectAtIndex:indexPath.row];
        }
    }
    
    [segue.destinationViewController setBrandName:brandName];
}

@end
