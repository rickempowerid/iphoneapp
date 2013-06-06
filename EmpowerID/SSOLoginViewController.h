//
//  SSOLoginViewController.h
//  EmpowerID
//
//  Created by R on 5/29/13.
//  Copyright (c) 2013 R. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSOLoginViewController : UITableViewController <UITableViewDataSource, UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property NSMutableArray *ssoData;

@end
