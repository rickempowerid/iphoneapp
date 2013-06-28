//
//  SSOLoginWeb.m
//  EmpowerID
//
//  Created by R on 6/5/13.
//  Copyright (c) 2013 R. All rights reserved.
//

#import "SSOLoginWebViewController.h"
#import "Globals.h"
#import "Helpers.h"
#import "MainTabControllerViewController.h"
@implementation SSOLoginWebViewController
@synthesize webView, authenticateUrl;

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [cookieJar cookies]) {
        if ([[cookie domain] isEqualToString:[Globals sharedManager].host]) {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
        }
    }
    
    
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
            if ([[cookie name] isEqualToString:@"oauth_token"]) {
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
        token = [webView stringByEvaluatingJavaScriptFromString: @"document.body.innerHTML"];
        NSLog(token);
        NSData *jsonData = [token dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments error:&error];
        
        if (! jsonDict) {
            NSLog(@"Got an error: %@", error);
        } else {
            if([Helpers ProcessOauthResponse: jsonDict])
            {
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryBoard" bundle: nil];
                MainTabControllerViewController *viewCon = [storyboard instantiateViewControllerWithIdentifier:@"MainToolbar"];

                [[UIApplication sharedApplication].delegate.window setRootViewController:viewCon];
            
            }
        }
        
    }
}

@end
