//
//  SettingsViewController.h
//  EmpowerID
//
//  Created by R on 5/29/13.
//  Copyright (c) 2013 R. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *textHost;
@property (weak, nonatomic) IBOutlet UITextField *textSSO;
- (IBAction)doneAction:(id)sender;

@end
