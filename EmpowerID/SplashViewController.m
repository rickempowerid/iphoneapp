//
//  SplashViewController.m
//  EmpowerID
//
//  Created by R on 5/3/13.
//  Copyright (c) 2013 R. All rights reserved.
//

#import "SplashViewController.h"
#import "AFJSONRequestOperation.h"
#import "Base64Utility.h"
#import "AFHTTPClient.h"
#import "Helpers.h"
#import "Globals.h"
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
-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [NSThread sleepForTimeInterval:2.0001];
    [self checkToken];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //wait((int*)4);
	
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)showLoginScreen
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryBoard" bundle: nil];
    LoginController *lvc = [storyboard instantiateViewControllerWithIdentifier:@"LoginController"];
    [self presentViewController:lvc animated:YES completion: nil];
}
-(void)getKeyFromRefreshToken
{
    
    NSURL *url = [NSURL URLWithString:@"https://sso.empowerid.com/EmpowerIDOAuth/oauth2/token"];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [httpClient setDefaultHeader:@"Accept" value:@"application/json"];
    NSDictionary *params = [[NSDictionary alloc] init];
    
    NSDictionary *data = [[NSDictionary alloc] initWithObjectsAndKeys:
                          @"EF8BCFC5-1B66-44CD-835F-BD3BB199FFDE",@"client_id",  @"8E3E2ADE-0D43-473A-8DB9-0FD0BBF6139E",@"client_secret",  [Globals sharedManager].refreshtoken,@"refresh_token",  @"refresh_token", @"grant_type", nil];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    NSString *jsonString = nil;
    
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"" parameters: params];
    //[request setValue:[self getAuthenticationHeader:@"empoweridadmin" password:@"p@$$w0rd"] forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSData *requestData = [NSData dataWithBytes:[jsonString UTF8String] length:[jsonString length]];
    
    [request setHTTPBody:requestData];
    NSLog(@"%@", jsonString);
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            NSLog(@"Success");
                                                                                            NSLog(@"%@",JSON);
                                                                                            [Globals sharedManager].token = (NSString*)[JSON objectForKey:@"access_token"];
                                                                                            
                                                                                            if([Globals sharedManager].token == nil || [[Globals sharedManager].token isEqualToString:@""])
                                                                                            {
                                                                                                [self showLoginScreen];
                                                                                                
                                                                                            }
                                                                                            else
                                                                                            {
                                                                                                
                                                                                                int integer = (int)[JSON objectForKey:@"expires_in"];
                                                                                                
                                                                                                NSDate *expires = [[NSDate date] dateByAddingTimeInterval:(60*integer)];
                                                                                                
                                                                                                [Globals sharedManager].refreshtoken = (NSString*)[JSON objectForKey:@"refresh_token"];
                                                                                                
                                                                                                [Globals sharedManager].expires = expires;
                                                                                                
                                                                                                [self transitionToView];
                                                                                                [Globals sharedManager].token = (NSString*)[JSON objectForKey:@"access_token"];
                                                                                            }
                                                                                            
                                                                                            
                                                                                        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                                                            NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
                                                                                            NSLog(@"Failure to get token from refresh token");
                                                                                            
                                                                                            [self showLoginScreen];
                                                                                        }];
    
    [operation start];
    
}
-(void)transitionToView
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryBoard" bundle: nil];
    UITabBarController *lvc = [storyboard instantiateViewControllerWithIdentifier:@"MainToolbar"];
    [self presentViewController:lvc animated:NO completion: nil];
    //[self transitionFromViewController:self toViewController:lvc duration:1.0 options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {  }];
}
-(void) checkToken
{
    if([[Globals sharedManager].token length] == 0)
    {
        
        [self showLoginScreen];
        return;
    }
    
[self validateToken];

    
}
-(void) validateToken
{
    NSURL *url = [NSURL URLWithString:@"https://sso.empowerid.com/EmpowerIDOAuth/oauth2/tokeninfo"];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [httpClient setDefaultHeader:@"Accept" value:@"application/json"];
    NSDictionary *params = [[NSDictionary alloc] init];
    
    NSDictionary *data = [[NSDictionary alloc] initWithObjectsAndKeys:
                           [Globals sharedManager].token,@"access_token", nil];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    NSString *jsonString = nil;
    
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"" parameters: params];
    //[request setValue:[self getAuthenticationHeader:@"empoweridadmin" password:@"p@$$w0rd"] forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSData *requestData = [NSData dataWithBytes:[jsonString UTF8String] length:[jsonString length]];
    
    [request setHTTPBody:requestData];
    NSLog(@"%@", jsonString);
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            NSLog(@"Success");
                                                                                            NSLog(@"Validating token: %@",JSON);
                                                                                            
                                                                                            if((int)[JSON objectForKey:@"expires_in"] > 0)
                                                                                            {
                                                                                                [self transitionToView];
                                                                                            }
                                                                                            else
                                                                                            {
                                                                                                [self getKeyFromRefreshToken];
                                                                                            }
                                                                                            
                                                                                            
                                                                                        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {

                                                                                            [self getKeyFromRefreshToken];
                                                                                        }];
    
    [operation start];

}
@end
