//
//  SSOLoginViewController.m
//  EmpowerID
//
//  Created by R on 5/29/13.
//  Copyright (c) 2013 R. All rights reserved.
//

#import "SSOLoginViewController.h"
#import "UIImageView+WebCache.h"
#import "Helpers.h"
#import "Globals.h"
#import "SSOLoginWebViewController.h"

@interface SSOLoginViewController ()

@end

@implementation SSOLoginViewController
@synthesize ssoData;

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
    
    self.ssoData = [[NSMutableArray alloc] init];
    //[self.collectionView layout
    [self loadData];
    //[self.view addSubview:self.webView];
    //[self.webView setBounds:self.tableView.bounds];
    // Do any additional setup after loading the view from its nib.
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
    NSString* token = [self getTokenFromCookie];
    if (token != nil) {
        //[self.delegate gotToken:token];
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * path = [[self.ssoData objectAtIndex:indexPath.row] valueForKey:@"Url"];
    
    [self loadAuthenticateUrl: path];
    
    
}


- (void)loadAuthenticateUrl:(NSString *)authenticateUrl {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryBoard" bundle: nil];
    SSOLoginWebViewController *lvc = [storyboard instantiateViewControllerWithIdentifier:@"SSOLoginWebViewController"];
    
    lvc.authenticateUrl = authenticateUrl;
    lvc.webView.scalesPageToFit = YES;
    //self.domain = [[NSURL URLWithString:authenticateUrl] host];
    //[self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.google.com"]]];
    
    //self.webView.hidden = NO;
    [self presentViewController:lvc animated:YES completion: nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

     - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
         // Only one section.
         return 1;
     }
     
     
     - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
         // Only one section, so return the number of items in the list.
         return self.ssoData.count;
     }


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *tile = [self.ssoData objectAtIndex:indexPath.row];
    
        static NSString *identifier = @"SSOCell";
        NSString *path = [Helpers getQueryString:[tile valueForKey:@"Icon"]];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        
        UIImageView *imageView = (UIImageView *)[cell viewWithTag:100];
        //recipeImageView.image = [imageArray objectAtIndex:indexPath.section * noOfSection + indexPath];
        
        [imageView setImageWithURL:[NSURL URLWithString:path] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        
        UILabel *labelView = (UILabel *)[cell viewWithTag:101];
        
        labelView.text = [tile valueForKey:@"Title"];
        
        
        return cell;
        
    }

-(void)loadData
{
    //[self.refreshControl beginRefreshing];
    NSString *host = [Globals sharedManager].host;
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:host, @"domain", @"EmpowerID", @"serviceProvider", nil];
    
    
    [Helpers LoadAction:@"/EmpowerIDWebIdPForms/GetSSOTiles" parameters:dict success:^(id JSON) {
        NSLog(@"%@", JSON);
        NSArray* arr1 = [(NSDictionary*)JSON valueForKey:@"Tiles"];
        [self.ssoData addObjectsFromArray: arr1];
        
        [self.tableView reloadData];
        //[self.refreshControl endRefreshing];
    } failure:^(NSError *error, id JSON) {
        //[self.refreshControl endRefreshing];
        [Helpers showMessageBox:@"error" description:@"an error occurred"];
    } addAuthHeader:NO];
}


@end
