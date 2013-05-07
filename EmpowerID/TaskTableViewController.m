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

@implementation TaskTableViewController

#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.finishedLoading = [[NSArray alloc] init];
	self.title = NSLocalizedString(@"Plays", @"Master view navigation title");
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Only one section.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Only one section, so return the number of items in the list.
    return [self.taskData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *tempDictionary= [self.taskData objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [tempDictionary objectForKey:@"name"];
    

    cell.detailTextLabel.text = [tempDictionary   objectForKey:@"description"];

    
    return cell;
}

-(void)loadData
{
    [Helpers LoadData:@"BusinessProcessTaskView" methodName:@"GetMyTasks" includedProperties:[[NSArray alloc] init] parameters:[[NSArray alloc] init] success:^(id JSON) {
        
    } failure:^(NSError *error, id JSON) {

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
