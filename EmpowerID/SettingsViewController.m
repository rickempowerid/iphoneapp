//
//  SettingsViewController.m
//  EmpowerID
//
//  Created by R on 5/29/13.
//  Copyright (c) 2013 R. All rights reserved.
//

#import "SettingsViewController.h"
#import "Globals.h"
@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.textHost.text = [Globals sharedManager].host;
    self.textSSO.text = [Globals sharedManager].SSOName;
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillDisappear:(BOOL)animated
{
    [Globals sharedManager].host = self.textHost.text;
    [Globals sharedManager].SSOName = self.textSSO.text;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
