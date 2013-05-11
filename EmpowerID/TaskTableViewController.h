//
//  TaskTableViewController.h
//  EmpowerID
//
//  Created by R on 5/1/13.
//  Copyright (c) 2013 R. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskTableViewController : UITableViewController <UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIRefreshControl *refreshControl;

@property (strong, nonatomic) NSArray *finishedLoading;
@end
