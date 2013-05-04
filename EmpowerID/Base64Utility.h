//
//  Base64Utility.h
//  EmpowerID
//
//  Created by R on 5/3/13.
//  Copyright (c) 2013 R. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Base64Utility : NSObject
+ (NSString *) base64EncodeString: (NSString *) strData;

+ (NSString *) base64EncodeData: (NSData *) objData;
@end
