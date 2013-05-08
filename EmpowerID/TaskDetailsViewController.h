//
//  TaskDetailsViewController.h
//  EmpowerID
//
//  Created by R on 5/3/13.
//  Copyright (c) 2013 R. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface BusinessProcessTask : NSObject
@property NSArray* Decisions;
@property NSString* Name;
@property NSString* Description;
@property NSString* Status;

@end
@interface TaskDetailsViewController : UITableViewController<UITableViewDataSource>
@property (strong, atomic) BusinessProcessTask* data;
@end
