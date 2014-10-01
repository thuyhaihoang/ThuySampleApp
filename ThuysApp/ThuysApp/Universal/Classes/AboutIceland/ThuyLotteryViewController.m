//
//  ThuyLotteryViewController.m
//  ThuysApp
//
//  Created by Thuy Hoang on 9/25/14.
//  Copyright (c) 2014 Thuy Hoang. All rights reserved.
//

#import "ThuyLotteryViewController.h"
#import "ThuyLottery.h"

@interface ThuyLotteryViewController ()

@property (nonatomic, strong, readonly) NSArray *lotteries;

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong, readonly) ThuyIcelandServiceHelper *icelandServiceHelper;

- (IBAction)close:(id)sender;

@end

@implementation ThuyLotteryViewController

//prototype cell tags
static int dateTag = 1;
static int lottoTag = 2;
static int jokerTag = 3;
static int prizeTag = 4;
//cell names
static NSString *lotteryCell = @"LotteryCell";

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
    _icelandServiceHelper = [[ThuyIcelandServiceHelper alloc] initWithDelegate:self];

}

- (void)viewWillAppear:(BOOL)animated {
    [self.icelandServiceHelper allLotteries];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions
- (void)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger actualNumberOfRows = [self.lotteries count];
    
    return (actualNumberOfRows == 0) ? 1 : actualNumberOfRows;
}

#pragma mark - Table View Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger actualNumberOfRows = [self.lotteries count];
    NSString *CellIdentifier = lotteryCell;
    if (actualNumberOfRows == 0) {
        CellIdentifier = @"TableCell";
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (actualNumberOfRows == 0) {
        cell.textLabel.text = @"No Lotteries found.";
        cell.textLabel.textColor = [UIColor blackColor];
        return cell;
    }
    UILabel *dateLbl = (UILabel *)[cell.contentView viewWithTag:dateTag];
    UILabel *lottoLbl = (UILabel *)[cell.contentView viewWithTag:lottoTag];
    UILabel *jokerLbl = (UILabel *)[cell.contentView viewWithTag:jokerTag];
    UILabel *prizeLbl = (UILabel *)[cell.contentView viewWithTag:prizeTag];
    
    ThuyLottery *lottery = [self.lotteries objectAtIndex:indexPath.row];
    dateLbl.text = lottery.date;
    lottoLbl.text = lottery.lotto;
    jokerLbl.text = lottery.joker;
    prizeLbl.text = lottery.prize;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath row] % 2) {
        [cell setBackgroundColor:[UIColor whiteColor]];
    } else {
        [cell setBackgroundColor:[UIColor lightGrayColor]];
    }
}

#pragma mark - Iceland Service Delagate
- (void)icelandServiceDidStart:(ThuyIcelandServiceType)serviceType {
    if (serviceType == ThuyIcelandServiceLotteries) {
        NSLog(@"starting service");
    }
}

- (void)icelandServiceType:(ThuyIcelandServiceType)serviceType failedWithError:(NSError *)error {
    [[[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
}

- (void)gotLotteries:(NSArray *)lotteries {
    _lotteries = lotteries;
    [self.tableView reloadData];
}


@end
