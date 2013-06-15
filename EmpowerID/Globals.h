//
//  Globals.h
//  EmpowerID
//
//  Created by R on 5/8/13.
//  Copyright (c) 2013 R. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Globals : NSObject {
    NSString *token;
}

@property (nonatomic, retain) NSString *token;
@property (nonatomic, retain) NSString *refreshtoken;
@property (nonatomic, retain) NSDate *expires;
@property (nonatomic, retain) NSString *host;
@property (nonatomic, retain) NSString *SSOName;
+ (Globals*)sharedManager;

@end
