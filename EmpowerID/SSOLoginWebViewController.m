//
//  SSOLoginWeb.m
//  EmpowerID
//
//  Created by R on 6/5/13.
//  Copyright (c) 2013 R. All rights reserved.
//

#import "SSOLoginWebViewController.h"
#import "Globals.h"
@implementation SSOLoginWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"www.google.com"]]];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
