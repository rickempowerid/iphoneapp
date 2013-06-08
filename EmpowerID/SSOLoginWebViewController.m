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
@synthesize webView, authenticateUrl;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //[self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.google.com"]]];
}


-(void)viewDidAppear:(BOOL)animated
{
    self.webView.delegate = (id<UIWebViewDelegate>)self.presentingViewController;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.authenticateUrl]]];

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

- (IBAction)closeClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
