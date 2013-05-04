//
//  LoginController.m
//  EmpowerID
//
//  Created by R on 5/3/13.
//  Copyright (c) 2013 R. All rights reserved.
//

#import "LoginController.h"
#import "Base64Utility.h"
#import "AFJSONRequestOperation.h"
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
+(NSString*)getAuthenticationHeader:(NSString*)username password:(NSString*)password
{
    NSString* message = [NSString stringWithFormat:@"Basic %@:%@",username,password];
    message = [Base64Utility base64EncodeString:message];
    return message;
}
-(void)processLogin
{
    NSURL *url = [NSURL URLWithString:@"https://sso.empowerid.com/EmpowerIDOAuth/oauth2/token"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:[LoginController getAuthenticationHeader:@"empoweridadmin" password:@"p@$$w0rd"] forHTTPHeaderField:@"Authentication"];
    //AFNetworking asynchronous url request
    AFJSONRequestOperation *operation = [AFJSONRequestOperation
                                         JSONRequestOperationWithRequest:request
                                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, id responseObject)
                                         {
                                             NSLog(@"JSON RESULT %@", responseObject);
                                             
                                         }
                                         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id responseObject)
                                         {
                                             NSLog(@"Request Failed: %@, %@", error, error.userInfo);
                                         }];
    
    [operation start];
    
}

@end
