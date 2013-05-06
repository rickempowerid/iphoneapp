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
      message = [Base64Utility base64EncodeString:message];
    return message;
}
-(void)processLogin
{
    
    NSURL *url = [NSURL URLWithString:@"https://sso.empowerid.com/EmpowerIDOAuth/oauth2/token"];

    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [httpClient setDefaultHeader:@"Accept" value:@"application/json"];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"client_id", @"EF8BCFC5-1B66-44CD-835F-BD3BB199FFDE",
                            @"client_secret", @"8E3E2ADE-0D43-473A-8DB9-0FD0BBF6139E",
                            @"redirect_uri", @"https://myredirect.afterpost.now",
                            @"grant_type", @"password",
                            nil];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"" parameters:params];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            NSLog(@"Success");
                                                                                            NSLog(@"%@",JSON);
                                                                                            
                                                                                        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                                                            NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
                                                                                            NSLog(@"Failure");
                                                                                        }];
    
    [operation start];
    
}


@end
