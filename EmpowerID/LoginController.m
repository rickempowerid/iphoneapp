//
//  LoginController.m
//  EmpowerID
//
//  Created by R on 5/3/13.
//  Copyright (c) 2013 R. All rights reserved.
//

#import "LoginController.h"
#import "AFJSONRequestOperation.h"
#import "Base64Utility.h"
#import "AFHTTPClient.h"
#import "Helpers.h"

@interface LoginController ()

@end

@implementation LoginController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)loginClicked:(id)sender {
    [self processLogin];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSString*)getAuthenticationHeader:(NSString*)username password:(NSString*)password
{
       NSString* message = [NSString stringWithFormat:@"%@:%@",username,password];
      message = [NSString stringWithFormat:@"Basic %@",[Base64Utility base64EncodeString:message]];
    return message;
}
-(void)processLogin
{
    
    NSURL *url = [NSURL URLWithString:@"https://sso.empowerid.com/EmpowerIDOAuth/oauth2/token"];

    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [httpClient setDefaultHeader:@"Accept" value:@"application/json"];
    NSDictionary *params = [[NSDictionary alloc] init];
    
    NSDictionary *data = [[NSDictionary alloc] initWithObjectsAndKeys:
                           @"EF8BCFC5-1B66-44CD-835F-BD3BB199FFDE",@"client_id",  @"8E3E2ADE-0D43-473A-8DB9-0FD0BBF6139E",@"client_secret",  @"",@"redirect_uri",  @"password", @"grant_type", nil];
    
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
    [request setValue:[self getAuthenticationHeader:@"empoweridadmin" password:@"p@$$w0rd"] forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSData *requestData = [NSData dataWithBytes:[jsonString UTF8String] length:[jsonString length]];
    
    [request setHTTPBody:requestData];
    NSLog(@"%@", jsonString);
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            NSLog(@"Success");
                                                                                            NSLog(@"%@",JSON);
                                                                                            Helpers.token = (NSString*)[JSON objectForKey:@"access_token"];
                                                                                            [self transitionToView];
                                                                                            
                                                                                        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                                                            NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
                                                                                            NSLog(@"Failure");
                                                                                        }];
    
    [operation start];
    
}
-(void)transitionToView
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryBoard" bundle: nil];
    UITabBarController *lvc = [storyboard instantiateViewControllerWithIdentifier:@"MainToolbar"];
    [self presentViewController:lvc animated:YES completion: nil];
    //[self transitionFromViewController:self toViewController:lvc duration:1.0 options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {  }];
}

@end
