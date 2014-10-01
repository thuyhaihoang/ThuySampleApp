//
//  ThuyLearnAboutIcelandViewController.m
//  ThuysApp
//
//  Created by Thuy Hoang on 9/25/14.
//  Copyright (c) 2014 Thuy Hoang. All rights reserved.
//

#import "ThuyLearnAboutIcelandViewController.h"

@interface ThuyLearnAboutIcelandViewController ()

- (IBAction)getLotteries:(id)sender;
- (IBAction)getEarthquakes:(id)sender;

@end

@implementation ThuyLearnAboutIcelandViewController

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
}

#pragma mark - IBActions
- (void)getLotteries:(id)sender {
    [self performSegueWithIdentifier:@"viewLotteryResults" sender:self];
}

- (void)getEarthquakes:(id)sender {
    [self performSegueWithIdentifier:@"viewEarthquakes" sender:self];
}


@end
