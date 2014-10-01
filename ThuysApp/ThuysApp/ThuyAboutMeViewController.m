//
//  ThuyAboutMeViewController.m
//  ThuysApp
//
//  Created by Thuy Hoang on 9/25/14.
//  Copyright (c) 2014 Thuy Hoang. All rights reserved.
//

#import "ThuyAboutMeViewController.h"

@interface ThuyAboutMeViewController ()

- (IBAction)viewThuysResume:(id)sender;

@end

@implementation ThuyAboutMeViewController

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

#pragma mark - IBAction
- (IBAction)viewThuysResume:(id)sender {
    QLPreviewController *previewController = [[QLPreviewController alloc] init];
    previewController.dataSource = self;
    previewController.delegate = self;
    
    // start previewing the document at the current section index
    previewController.currentPreviewItemIndex = 0;
    [previewController setModalPresentationStyle:UIModalPresentationFullScreen];
    [previewController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:previewController animated:YES completion:nil];
}

#pragma mark - QLPreviewControllerDataSource

// Returns the number of items that the preview controller should preview
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)previewController {
    return 1;
}

- (void)previewControllerDidDismiss:(QLPreviewController *)controller
{
    // if the preview dismissed (done button touched), use this method to post-process previews
}

// returns the item that the preview controller should preview
- (id)previewController:(QLPreviewController *)previewController previewItemAtIndex:(NSInteger)idx
{
    NSURL *fileURL = nil;
    
    fileURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"ThuyHoangResume2014" ofType:@"pdf"]];
    
    return fileURL;
}



@end
