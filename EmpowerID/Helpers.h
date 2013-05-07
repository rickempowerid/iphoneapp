//
//  BusinessProcessTask.h
//  EmpowerID
//
//  Created by R on 5/6/13.
//  Copyright (c) 2013 R. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Helpers : NSObject
+(NSString*) token;
+(void) settoken: (NSString*) value;

+(void)LoadData:(NSString*)typeName methodName:(NSString*)methodName includedProperties:(NSArray*)includedProperties parameters:(NSArray*)parameters success:(void (^)(id JSON))success
        failure:(void (^)(NSError *error, id JSON))failure;

@end
