//
//  ThuyEarthquakeViewController.m
//  ThuysApp
//
//  Created by Thuy Hoang on 9/25/14.
//  Copyright (c) 2014 Thuy Hoang. All rights reserved.
//

#import "ThuyEarthquakeViewController.h"
#import "ThuyEarthquake.h"

@interface ThuyEarthquakeViewController ()

@property (nonatomic, strong, readonly) NSArray *earthquakes;

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong, readonly) ThuyIcelandServiceHelper *icelandServiceHelper;

- (IBAction)close:(id)sender;

@end

@implementation ThuyEarthquakeViewController

//prototype cell tags
static int timestampTag = 1;
static int latitudeTag = 2;
static int longitudeTag = 3;
static int depthTag = 4;
static int sizeTag = 5;
static int locationTag = 6;
//cell names
static NSString *earthquakeCell = @"EarthquakeCell";

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
    [self.icelandServiceHelper allEarthquakes];
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
    NSInteger actualNumberOfRows = [self.earthquakes count];
    
    return (actualNumberOfRows == 0) ? 1 : actualNumberOfRows;
}

#pragma mark - Table View Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger actualNumberOfRows = [self.earthquakes count];
    NSString *CellIdentifier = earthquakeCell;
    if (actualNumberOfRows == 0) {
        CellIdentifier = @"TableCell";
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (actualNumberOfRows == 0) {
        cell.textLabel.text = @"No Earthquakes found.";
        cell.textLabel.textColor = [UIColor blackColor];
        return cell;
    }
    UILabel *timestampLbl = (UILabel *)[cell.contentView viewWithTag:timestampTag];
    UILabel *latitudeLbl = (UILabel *)[cell.contentView viewWithTag:latitudeTag];
    UILabel *longitudeLbl = (UILabel *)[cell.contentView viewWithTag:longitudeTag];
    UILabel *depthLbl = (UILabel *)[cell.contentView viewWithTag:depthTag];
    UILabel *sizeLbl = (UILabel *)[cell.contentView viewWithTag:sizeTag];
    UILabel *locationLbl = (UILabel *)[cell.contentView viewWithTag:locationTag];
    
    ThuyEarthquake *earthquake = [self.earthquakes objectAtIndex:indexPath.row];
    timestampLbl.text = earthquake.timestamp;
    latitudeLbl.text = [earthquake.latitude stringValue];
    longitudeLbl.text = [earthquake.longitude stringValue];
    depthLbl.text = [earthquake.depth stringValue];
    sizeLbl.text = [earthquake.size stringValue];
    locationLbl.text = earthquake.humanReadableLocation;

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
    if (serviceType == ThuyIcelandEarthquakes) {
        NSLog(@"starting service");
    }
}

- (void)icelandServiceType:(ThuyIcelandServiceType)serviceType failedWithError:(NSError *)error {
    [[[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
}

- (void)gotEarthquakes:(NSArray *)earthquakes {
    _earthquakes = earthquakes;
    [self.tableView reloadData];
}

@end
