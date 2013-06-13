//
//  MainTabControllerViewController.m
//  EmpowerID
//
//  Created by R on 5/8/13.
//  Copyright (c) 2013 R. All rights reserved.
//

#import "MainTabControllerViewController.h"
#import "Helpers.h"
#import "ViewController.h"
#import "UIViewController+JTRevealSidebarV2.h"
#import "UINavigationItem+JTRevealSidebarV2.h"
#import "SidebarViewController.h"
#import "NewViewController.h"


@interface MainTabControllerViewController ()

@end

@implementation MainTabControllerViewController




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    //[Helpers setupLogoutButton:self];
    //[(UITabBarController*)self.navigationController.topViewController setSelectedIndex:2];

    
    self.navigationItem.revealSidebarDelegate = self;
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
