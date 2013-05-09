//
//  HomeControllerViewController.m
//  EmpowerID
//
//  Created by R on 5/8/13.
//  Copyright (c) 2013 R. All rights reserved.
//

#import "HomeControllerViewController.h"
#import "Helpers.h"

@interface HomeControllerViewController ()

@end

@implementation HomeControllerViewController

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
    [Helpers setupLogoutButton:self];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
