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

+(void)LoadData:(NSString*)typeName methodName:(NSString*)methodName includedProperties:(NSArray*)includedProperties parameters:(NSArray*)parameters success:(void (^)(id JSON))success
        failure:(void (^)(NSError *error, id JSON))failure;
+(void)showMessageBox: (NSString *)message description:(NSString*)description;

@end
