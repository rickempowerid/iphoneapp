//
//  SSOLoginViewController.m
//  EmpowerID
//
//  Created by R on 5/29/13.
//  Copyright (c) 2013 R. All rights reserved.
//

#import "SSOLoginViewController.h"
#import "UIImageView+WebCache.h"
#import "Helpers.h"
#import "Globals.h"
@interface SSOLoginViewController ()

@end

@implementation SSOLoginViewController
@synthesize data;

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
    [self loadData];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
 static NSString *identifier = @"Cell";
    NSString *path = [Helpers getQueryString:[(NSDictionary*)[data objectAtIndex:indexPath.row] valueForKey:@"SSOImageUrl"]];
UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];

UIImageView *imageView = (UIImageView *)[cell viewWithTag:100];
//recipeImageView.image = [imageArray objectAtIndex:indexPath.section * noOfSection + indexPath];

    [imageView setImageWithURL:[NSURL URLWithString:path] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
return cell;
}

-(void)loadData
{
    //[self.refreshControl beginRefreshing];
    NSString *host = [Globals sharedManager].host;
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:host, @"domain", @"EmpowerID", @"serviceProvider", nil];
    
    
    [Helpers LoadAction:@"/EmpowerIDWebIdPForms/GetTilesByDomain" parameters:dict success:^(id JSON) {
        NSLog(@"%@", JSON);
        NSArray* arr1 = (NSArray*)[(NSDictionary*)JSON objectForKey:@"Data"];
        self.data = arr1;
        
        [self.collectionView reloadData];
        //[self.refreshControl endRefreshing];
    } failure:^(NSError *error, id JSON) {
        //[self.refreshControl endRefreshing];
        [Helpers showMessageBox:@"error" description:@"an error occurred"];
    }];
}


@end
