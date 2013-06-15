//
//  ContainerViewController.h
//  EmpowerID
//
//  Created by R on 6/12/13.
//  Copyright (c) 2013 R. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JTRevealSidebarV2Delegate.h"
#import "SidebarViewController.h"
@interface ContainerViewController : UIViewController

@property (nonatomic, strong) SidebarViewController *leftSidebarViewController;
@property (nonatomic, strong) UITableView *rightSidebarView;
@property (nonatomic, strong) NSIndexPath *leftSelectedIndexPath;
@property (nonatomic, strong) UILabel *label;

@end
