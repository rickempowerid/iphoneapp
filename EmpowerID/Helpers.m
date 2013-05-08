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
@implementation Helpers



+(void)LoadData:(NSString*)typeName methodName:(NSString*)methodName includedProperties:(NSArray*)includedProperties parameters:(NSArray*)parameters success:(void (^)(id JSON))success
        failure:(void (^)(NSError *error, id JSON))failure
{
    NSURL *url = [NSURL URLWithString:@"https://sso.empowerid.com/api/v1/query"];
    NSDictionary* data = [[NSDictionary alloc] initWithObjectsAndKeys:
                            @"MethodName", methodName, @"TypeName", typeName, @"IncludedProperties", includedProperties, @"Parameters", parameters, nil];
    
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
    
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [httpClient setDefaultHeader:@"Accept" value:@"application/json"];
    
    NSData *requestData = [NSData dataWithBytes:[jsonString UTF8String] length:[jsonString length]];

    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"" parameters: nil];
    [request setValue:[Globals sharedManager].token forHTTPHeaderField:@"Authorization"];
    [request setHTTPBody: requestData];
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
