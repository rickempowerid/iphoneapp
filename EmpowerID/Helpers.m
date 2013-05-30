//
//  BusinessProcessTask.m
//  EmpowerID
//
//  Created by R on 5/6/13.
//  Copyright (c) 2013 R. All rights reserved.
//

#import "Helpers.h"
#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"
#import "Globals.h"
#include "Base64Utility.h"
#import "LoginController.h"

@implementation Helpers
 
+(NSString*)getAuthenticationHeader
{
    NSString* message = [NSString stringWithFormat:@"Bearer %@", [Globals sharedManager].token];
    return message;
}

+(void)LoadData:(NSString*)typeName methodName:(NSString*)methodName includedProperties:(NSArray*)includedProperties parameters:(NSDictionary*)parameters success:(void (^)(id JSON))success
        failure:(void (^)(NSError *error, id JSON))failure
{
    
    NSURL *url = [NSURL URLWithString:@"https://sso.empowerid.com/EmpowerIDv5/api/v1/query"];
    NSDictionary* data = [[NSDictionary alloc] initWithObjectsAndKeys:
                            methodName, @"MethodName" , typeName, @"TypeName", includedProperties, @"IncludedProperties", [Helpers buildParameters:parameters], @"Parameters" , nil];
    
    NSDictionary *params = [[NSDictionary alloc] init];
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
    
    NSLog(@"writing HEADER %@", [Helpers getAuthenticationHeader]);
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [httpClient setDefaultHeader:@"Accept" value:@"application/json"];
    
    
    NSData *requestData = [NSData dataWithBytes:[jsonString UTF8String] length:[jsonString length]];

    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"" parameters: params];
    [request setValue:[Helpers getAuthenticationHeader] forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody: requestData];
    NSLog(@"%@", jsonString);
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            success(JSON);
                                                                                            NSLog(@"Success");
                                                                                            NSLog(@"%@",JSON);
                                                                                            
                                                                                        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                                                            failure(error, JSON);
                                                                                            NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
                                                                                            NSLog(@"Failure");
                                                                                        }];
    
    [operation start];
}
+(void) setupLogoutButton: (UIViewController*) view
{
    id block = [^
    {
    
    } copy];
    
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Logout"
                                   style:UIBarButtonItemStylePlain
                                   target:[UIApplication sharedApplication].delegate
                                   action:@selector(showLoginScreen)];
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"three_lines@2x.png"]
                                   style:UIBarButtonItemStyleBordered
                                   target:block
                                   action: @selector(invoke)];
    view.navigationItem.leftBarButtonItem = menuButton;
    view.navigationItem.rightBarButtonItem = saveButton;
    
    
}
+(void)logout: (UIViewController*)view
{
    [Globals sharedManager].token = @"";
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryBoard" bundle: nil];
    LoginController *lvc = [storyboard instantiateViewControllerWithIdentifier:@"LoginController"];
    [view presentViewController:lvc animated:YES completion: nil];
}
+(NSMutableArray*) buildParameters: (NSDictionary*) dict
{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    
    for (NSString* key in dict) {
        NSDictionary *d1 = [[NSDictionary alloc] initWithObjectsAndKeys:[dict objectForKey:key], @"Value", key, @"Name", nil];
        
        [list addObject:d1];
        
    }
    return list;
    
}
+(void)showMessageBox: (NSString *)message description:(NSString*)description
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:message
                                                    message:description
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
