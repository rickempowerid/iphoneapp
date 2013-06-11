//
//  SSOLoginWeb.h
//  EmpowerID
//
//  Created by R on 6/5/13.
//  Copyright (c) 2013 R. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSOLoginWebViewController : UIViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
- (IBAction)closeClicked:(id)sender;
@property NSString *authenticateUrl;
@end
