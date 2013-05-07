//
//  SplashViewController.m
//  EmpowerID
//
//  Created by R on 5/3/13.
//  Copyright (c) 2013 R. All rights reserved.
//

#import "SplashViewController.h"
#import "LoginController.h"

@interface SplashViewController ()

@end

@implementation SplashViewController

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
    wait((int*)4);
	//UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryBoard" bundle: nil];
    //LoginController *lvc = [storyboard instantiateViewControllerWithIdentifier:@"LoginController"];
//    [self transitionFromViewController:self toViewController:lvc duration:1.0 options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {  }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
