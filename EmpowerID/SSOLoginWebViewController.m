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
    
    //self.webView.delegate = self;
    //[self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.google.com"]]];
}


-(void)viewDidAppear:(BOOL)animated
{
    self.webView.delegate = (id<UIWebViewDelegate>)self;
    
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

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    //[self updateButtons];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    //[self updateButtons];
}

- (NSString*)getTokenFromCookie {
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    for (cookie in [cookieJar cookies]) {
        NSLog([NSString stringWithFormat:@"%@", cookieJar]);
        if ([[cookie domain] isEqualToString:[Globals sharedManager].host]) {
            if ([[cookie name] isEqualToString:@"1oauth_token"]) {
                return [cookie value];
            }
        }
    }
    return nil;
}



- (void)webViewDidFinishLoad:(UIWebView *)theWebView
{
    NSString *html = [self.webView stringByEvaluatingJavaScriptFromString:
                      @"document.body.innerHTML"];

    
    NSString* token = [self getTokenFromCookie];
    if (token != nil) {
        //[self.delegate gotToken:token];
        [self.navigationController popViewControllerAnimated:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
