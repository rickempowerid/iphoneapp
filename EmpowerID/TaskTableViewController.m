//
//  TaskTableViewController.m
//  EmpowerID
//
//  Created by R on 5/1/13.
//  Copyright (c) 2013 R. All rights reserved.
//

#import "TaskTableViewController.h"
#import "TaskDetailsViewController.h"
#import "Helpers.h"
@interface TaskTableViewController()
    @property BOOL moreResults;
    @property (strong, nonatomic) NSMutableArray *taskData;
@end
@implementation TaskTableViewController

#pragma mark View lifecycle
@synthesize taskData,moreResults;

- (IBAction)editingBegan:(id)sender {
    [self loadData: 0];
}
- (IBAction)updateRequested:(id)sender {
    [self loadData: 0];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.taskData = [[NSMutableArray alloc] init];
    self.finishedLoading = [[NSArray alloc] init];
    [Helpers setupLogoutButton:self];
    [self loadData: 0];

}



#pragma mark -
#pragma mark Table view data source
-(void) setupRefreshControl
{
    [self.refreshControl endRefreshing];
    [self.refreshControl addTarget:self action:@selector(refreshControlRequest) forControlEvents:UIControlEventValueChanged];
    //self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Updating..."];
}
-(void)refreshControlRequest
{
    self.taskData = [[NSMutableArray alloc] init];
    [self.tableView reloadData];
    [self loadData: 0];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Only one section.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Only one section, so return the number of items in the list.
    return self.taskData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TaskCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
      

    if (indexPath.row < self.taskData.count - 1) {
        NSDictionary *tempDictionary= [self.taskData objectAtIndex:indexPath.row];
        
        cell.textLabel.text = [tempDictionary objectForKey:@"Name"];
        
        NSString *val = [tempDictionary objectForKey:@"FriendlyName"];
        
        cell.detailTextLabel.text = val;

    } else
    {
        cell.textLabel.text = @"Loading more data...";
        
        // User has scrolled to the bottom of the list of available data so simulate loading some more if we aren't already
        if (!self.refreshControl.isRefreshing)
        {
            [self loadData:self.taskData.count];
        }
    }
    return cell;

}





-(void)loadData: (int) currentPage
{
    if(currentPage == 0)
        moreResults = YES;
    
    [self.progressIndicator startAnimating];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[[NSString alloc] initWithFormat:@"%d", currentPage], @"start", @"10", @"pageLength", @"", @"columnsToSearch", @"", @"textToSearch", @"0", @"totalCount", nil];
    
    [Helpers LoadData:@"BusinessProcessTaskView" methodName:@"GetMyTasks" includedProperties:[[NSArray alloc] initWithObjects:@"Name",@"FriendlyName", nil] parameters:dict success:^(id JSON) {

        NSArray* arr1 = (NSArray*)[(NSDictionary*)JSON objectForKey:@"Data"];
        [self.taskData addObjectsFromArray: arr1];
        
        moreResults = arr1.count != 0;
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
        [self.progressIndicator stopAnimating];
    } failure:^(NSError *error, id JSON) {
        [self.progressIndicator stopAnimating];
        [self.refreshControl endRefreshing];
        [Helpers showMessageBox:@"error" description:@"an error occurred"];
    }];
}
#pragma mark -
#pragma mark Table view selection

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    /*
     When a row is selected, the segue creates the detail view controller as the destination.
     Set the detail view controller's detail item to the item associated with the selected row.
     */
    if ([[segue identifier] isEqualToString:@"ShowSelectedPlay"]) {
        
        NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
        TaskDetailsViewController *detailViewController = [segue destinationViewController];
        detailViewController.data = [self.taskData objectAtIndex:selectedRowIndex.row];
    }
}

@end
