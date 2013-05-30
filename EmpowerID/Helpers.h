//
//  BusinessProcessTask.h
//  EmpowerID
//
//  Created by R on 5/6/13.
//  Copyright (c) 2013 R. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Helpers : NSObject
extern NSString* token;
+(void) setupLogoutButton: (UIViewController*) view;
+(NSString*)getAuthenticationHeader;
+(void)LoadData:(NSString*)typeName methodName:(NSString*)methodName includedProperties:(NSArray*)includedProperties parameters:(NSDictionary*)parameters success:(void (^)(id JSON))success
        failure:(void (^)(NSError *error, id JSON))failure;
+(void)showMessageBox: (NSString *)message description:(NSString*)description;
+(void)logout: (UIViewController*)view;
+(NSString*)getQueryString: (NSString*)path;
@end
