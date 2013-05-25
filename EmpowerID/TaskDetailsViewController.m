//
//  TaskDetailsViewController.m
//  EmpowerID
//
//  Created by R on 5/3/13.
//  Copyright (c) 2013 R. All rights reserved.
//

#import "TaskDetailsViewController.h"
#import "Helpers.h"

@implementation TaskDetailsViewController

@synthesize data;


#pragma mark -
#pragma mark View lifecycle

- (void)viewWillAppear:(BOOL)animated {
    // Update the view with current data before it is displayed.
    [super viewWillAppear:animated];
    
    // Scroll the table view to the top before it appears
    //[self.tableView reloadData];
    //[self.tableView setContentOffset:CGPointZero animated:NO];
    self.title = [data objectForKey:@"Name"];
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setupRefreshControl];
    [self loadData];
}

-(void) setupRefreshControl
{
    
    [self.refreshControl addTarget:self action:@selector(refreshControlRequest) forControlEvents:UIControlEventValueChanged];
    
    [self.refreshControl endRefreshing];
}
-(void)refreshControlRequest
{
    [self loadData];
}

-(void)loadData
{
    [self.refreshControl beginRefreshing];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[[NSString alloc]initWithFormat: @"%@", [data objectForKey:@"BusinessProcessTaskID"]], @"businessProcessTaskID", nil];
    
    [Helpers LoadData:@"BusinessProcessTaskView" methodName:@"GetByBusinessProcessTaskID" includedProperties:[[NSArray alloc] initWithObjects:@"Name",@"FriendlyName",@"Description", @"BusinessProcessStatusName", @"BusinessProcessStatusID", @"BusinessProcessTaskStatusID",@"BusinessProcessTaskID", nil] parameters:dict success:^(id JSON) {
        NSLog(@"%@", JSON);
        NSArray* arr1 = (NSArray*)[(NSDictionary*)JSON objectForKey:@"Data"];
        self.data = (NSDictionary*)[arr1 objectAtIndex: 0];
        
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    } failure:^(NSError *error, id JSON) {
        [self.refreshControl endRefreshing];
        [Helpers showMessageBox:@"error" description:@"an error occurred"];
    }];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // There are three sections, for date, genre, and characters, in that order.
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
	/*
	 The number of rows varies by section.
	 */
    NSInteger rows = 0;
    switch (section) {
        case 0:
        case 1:
            // For genre and date there is just one row.
            rows = 1;
            break;
        case 2:
            // For the characters section, there are as many rows as there are characters.
            //rows = [data.Decisions count];
            if([self showRespondActions:data])
                rows = 2;
            else
                rows = 1;
            
            break;
        default:
            break;
    }
    return rows;
}

-(BOOL) showRespondActions: (NSDictionary*) d
{
    int taskStatus = (int)[d valueForKey:@"BusinessProcessTaskStatusID"];
    int status = (int)[d valueForKey:@"BusinessProcessStatusID"];
    
    return taskStatus == 1 && (status==1 || status == 7 || status == 8);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LabelCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    // Cache a date formatter to create a string representation of the date object.
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy"];
    }
    
    // Set the text in the cell for the section/row.
    
    NSString *cellText = nil;
    
    switch (indexPath.section) {
        case 0: //Name
            cellText = [data objectForKey:@"Name"];
            break;
        case 1: //Description
            cellText = [data objectForKey:@"FriendlyName"];
            break;
        case 2: //Status
            
            if([self showRespondActions:data])
            {
                if(indexPath.row == 0)
                    cellText = @"Approve";
                else
                    cellText = @"Reject";
                
            }
            else
            {
                cellText = [data objectForKey:@"BusinessProcessStatusName"];
                
            }
            break;
        default:
            break;
    }
    
    cell.textLabel.text = cellText;
    return cell;
}


#pragma mark -
#pragma mark Section header titles

/*
 HIG note: In this case, since the content of each section is obvious, there's probably no need to provide a title, but the code is useful for illustration.
 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSString *title = nil;
    switch (section) {
        case 0:
            title = @"Name";
            break;
        case 1:
            title =  @"Description";
            break;
        case 2:
            title = @"Status";
            break;
        default:
            break;
    }
    return title;
}



@end
