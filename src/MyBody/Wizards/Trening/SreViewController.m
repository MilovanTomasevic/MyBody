//
//  SreViewController.m
//  MyBody
//
//  Created by Milovan Tomasevic on 03/11/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//

#import "SreViewController.h"
#import "TreningMasterViewController.h"

@interface SreViewController (){
    TreningMasterViewController *masterVC;
}


@end

@implementation SreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    masterVC = (TreningMasterViewController*)self.parentViewController;
    
    self.currentText = [[NSString alloc]init];
    self.currentText = @"prazan";

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    masterVC.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithTitle:@"<"
                                                                                style:UIBarButtonItemStylePlain
                                                                               target:self
                                                                               action:@selector(customBackButtonPressed)];
    
    
    masterVC.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@">"
                                                                                 style:UIBarButtonItemStylePlain
                                                                                target:self
                                                                                action:@selector(nextPage)];

    masterVC.navigationItem.title = @"Sreda";

    
    self.pControl.selectedSegmentIndex = 2;

    [self segmentSwitch];
    [self segmentSwitchYesNo];
    
    if (![_currentText isEqualToString:@"prazan"]) {
        self.tvTrening.text = self.currentText;
    }
}

- (IBAction)segmentSwitch:(UISegmentedControl *)sender {
    
    [self segmentSwitchYesNo];
}


-(void)swipeleft:(UISwipeGestureRecognizer*)gestureRecognizer
{
    [self nextPage];
}

-(void)swiperight:(UISwipeGestureRecognizer*)gestureRecognizer
{
    [self customBackButtonPressed];
}

-(void)customBackButtonPressed
{
    [masterVC customBackButtonPressed];
}

-(void)nextPage
{
    LogI(@"Next button clicked u sreda");
    
    //trim string from edit text
    self.tvTrening.text = [self.tvTrening.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    self.fokusTreningIme.text = [self.fokusTreningIme.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if([self.tvTrening.text isEqualToString:@""]){
        [ALERT_PRESENTER presentAlertWithTitle:NSLocalizedString(@"error",nil) message:NSLocalizedString(@"msg_21",nil)];
        return;
    }
    if([self.fokusTreningIme.text isEqualToString:@""]){
        [ALERT_PRESENTER presentAlertWithTitle:NSLocalizedString(@"error",nil) message:NSLocalizedString(@"msg_21a",nil)];
        return;
    }
    [masterVC.treningDB setT3Fokus:self.fokusTreningIme.text];
    [masterVC.treningDB setT3Sadrzaj:self.tvTrening.text];
    self.currentText = masterVC.treningDB.t3Sadrzaj;
    LogI(@" setovani trening za sredu:   %@", masterVC.treningDB.t3Sadrzaj);
    
    [masterVC nextButtonPressed];
}
@end
