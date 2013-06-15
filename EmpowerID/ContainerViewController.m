//
//  ContainerViewController.m
//  EmpowerID
//
//  Created by R on 6/12/13.
//  Copyright (c) 2013 R. All rights reserved.
//

#import "ContainerViewController.h"
#import "Helpers.h"
#import "ViewController.h"
#import "SettingsViewController.h"
#import "UINavigationController+GZDrawer.h"
#import "SidebarViewController.h"
@interface ContainerViewController ()

@end

@implementation ContainerViewController

@synthesize leftSidebarViewController;
@synthesize rightSidebarView;
@synthesize leftSelectedIndexPath;
@synthesize label;

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
	// Do any additional setup after loading the view.
    
    UINavigationController *nav = self.navigationController;
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(30, 50, 260, 60)];
    self.label.backgroundColor = [UIColor clearColor];
    self.label.textColor = [UIColor whiteColor];
    self.label.textAlignment = UITextAlignmentCenter;
    self.label.numberOfLines = 2;
    [self.view addSubview:self.label];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"three_lines@2x"] style:UIBarButtonItemStyleBordered target:self action:@selector(revealLeftSidebar)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(revealRightSidebar)];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryBoard" bundle: nil];
    UIViewController *tabs = [storyboard instantiateViewControllerWithIdentifier:@"MainToolbar"];
    
    
    [self addChildViewController:tabs];
    tabs.view.frame=self.view.bounds;
    [self.view addSubview:tabs.view];
    [tabs didMoveToParentViewController:self];
    //[tabs.swapViewControllerButton setTitle:@"Swap" forState:UIControlStateNormal];
    
    //tabs.childNumberLabel.text=[NSString stringWithFormat:@"Child Number: %d",self.childNumber];

    [nav addSwipeRecognizerForStyle:DrawerLayoutStyleRightAnchored withTarget:self selector:@selector(revealRightSidebar)];
    [nav addSwipeRecognizerForStyle:DrawerLayoutStyleLeftAnchored withTarget:self selector:@selector(revealLeftSidebar)];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark Action

- (void)revealLeftSidebar {
    UITableViewController *controller = self.leftSidebarViewController;
    if ( ! controller) {
        self.leftSidebarViewController = [[SidebarViewController alloc] init];
        self.leftSidebarViewController.sidebarDelegate = self;
        controller = self.leftSidebarViewController;
        controller.title = @"LeftSidebarViewController";
    }
    
    self.navigationController.topViewController.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushDrawerViewController:self.leftSidebarViewController withStyle:DrawerLayoutStyleLeftAnchored animated:YES];

}

- (void)revealRightSidebar {
    
}



- (void)sidebarViewController:(SidebarViewController *)sidebarViewController didSelectObject:(NSObject *)object atIndexPath:(NSIndexPath *)indexPath {
    
    
    if(indexPath.row == 0)
    {
        [Helpers logout:self];
    
    }
    else if(indexPath.row == 1)
    {
        SettingsViewController *con = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
        self.view.userInteractionEnabled = YES;
        [self.navigationController pushViewController:con animated:YES];
        
        
    }
    
    return;
    
    
    ViewController *controller = [[ViewController alloc] init];
    controller.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];
    controller.title = (NSString *)object;
    controller.leftSidebarViewController = sidebarViewController;
    controller.leftSelectedIndexPath = indexPath;
    controller.label.text = [NSString stringWithFormat:@"Selected %@ from LeftSidebarViewController", (NSString *)object];
    sidebarViewController.sidebarDelegate = controller;
    [self.navigationController setViewControllers:[NSArray arrayWithObject:controller] animated:NO];
    
}

- (NSIndexPath *)lastSelectedIndexPathForSidebarViewController:(SidebarViewController *)sidebarViewController {
    return self.leftSelectedIndexPath;
}
@end
