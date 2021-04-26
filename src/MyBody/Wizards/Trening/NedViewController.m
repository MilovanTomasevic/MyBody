//
//  NedViewController.m
//  MyBody
//
//  Created by Milovan Tomasevic on 03/11/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//

#import "NedViewController.h"
#import "TreningMasterViewController.h"


@interface NedViewController (){
    TreningMasterViewController *masterVC;
    AppDelegate *appDelegate;
}


@end

@implementation NedViewController{
    NSString *userMail, *currentDate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    masterVC = (TreningMasterViewController*)self.parentViewController;
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.currentText = [[NSString alloc]init];
    self.currentText = @"prazan";
    userMail = [[NSUserDefaults standardUserDefaults] valueForKey:PREF_USER_EMAIL];
    
    NSDateFormatter *today=[[NSDateFormatter alloc] init];
    [today setDateFormat:@"dd.MM.yyyy. HH:mm:ss"];
    currentDate = [today stringFromDate:[NSDate date]];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    masterVC.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithTitle:@"<"
                                                                                style:UIBarButtonItemStylePlain
                                                                               target:self
                                                                               action:@selector(customBackButtonPressed)];
    
    masterVC.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(nextPage)];
    //doneBtn.title=@"Dodaj";
    
    masterVC.navigationItem.title = @"Nedelja";
    self.tvTrening.placeholder = @"Trening za nedelju:";
    
    self.pControl.selectedSegmentIndex = 6;

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
    LogI(@"Next button clicked u nedelji");
    
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
    
    [masterVC.treningDB setUserID:userMail];
    [masterVC.treningDB setT7Sadrzaj:self.tvTrening.text];
    [masterVC.treningDB setDatumUnosa:currentDate];
    [masterVC.treningDB setIzabraniTrening:NO];
    [masterVC.treningDB setT7Fokus:self.fokusTreningIme.text];
    
    self.currentText = masterVC.treningDB.t7Sadrzaj;
    LogI(@" setovani trening za nedelju:   %@", masterVC.treningDB.t7Sadrzaj);
    
    [ALERT_PRESENTER presentAlertControllerWithConfigurationHandler:^(MTAlertDescriptor * descriptor) {
        descriptor.priority = MTAlertPriorityNormal;
        descriptor.title = NSLocalizedString(@"Ime novog treninga", nil);
        descriptor.cancelTitle = NSLocalizedString(@"Cancel", nil);
        descriptor.otherTitles = @[NSLocalizedString(@"Ok", nil)];
        descriptor.alertValidator = [[MTAlertValidator alloc] initWithValidateEmptyAndLenght:YES lenght:NO andCharacterLenght:30];
        [descriptor setTextFieldConfig:^(UITextField *textField) {
            textField.keyboardType = UIKeyboardTypeAlphabet;
            textField.placeholder = NSLocalizedString(@"Unesite naziv treninga", nil);
        }];
        [descriptor setTapBlock:^(UIAlertController *controller, UIAlertAction *action, NSInteger buttonIndex) {
            if (buttonIndex != MTAlertBlocksCancelButtonIndex) {

                [masterVC.treningDB setIme:controller.textFields.firstObject.text];
                LogI(@" ime treninga:   %@", controller.textFields.firstObject.text);

                [masterVC addTreningSaveDone];
                
                //[appDelegate saveContext];
                //[MTSupport progressDone:@"Trening kreiran" andView:self.navigationController.view];
                
                //root page
                [self goToHomeView];
            }
        }];
    }];
    
    
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Ime novog treninga" message:@"" preferredStyle:UIAlertControllerStyleAlert];
//    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
//        textField.placeholder = @"Unesite naziv treninga";
//        //textField.secureTextEntry = YES;
//    }];
//    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        NSLog(@"naziv je %@", [[alertController textFields][0] text]);
//        //compare the current password and do action here
//         [masterVC.treningDB setIme:alertController.textFields.firstObject.text];
//        [masterVC addTreningSaveDone];
//        
//        [appDelegate saveContext];
//        [MTSupport progressDone:@"Trening kreiran" andView:self.navigationController.view];
//        [self goToHomeView];
//
//    }];
//    [alertController addAction:confirmAction];
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        NSLog(@"Canelled");
//    }];
//    [alertController addAction:cancelAction];
//    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)goToHomeView{
    //[NSThread sleepForTimeInterval:2.0f];   
    [self.navigationController popToRootViewControllerAnimated:YES];
}



@end
