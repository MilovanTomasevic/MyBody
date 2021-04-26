//
//  NeViewController.m
//  MyBody
//
//  Created by Milovan Tomasevic on 05/11/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//

#import "NeViewController.h"
#import "IshranaMasterViewController.h"

@interface NeViewController (){
    IshranaMasterViewController *masterVC;
}


@end

@implementation NeViewController{
    NSString *userMail;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    masterVC = (IshranaMasterViewController*)self.parentViewController;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    userMail = [[NSUserDefaults standardUserDefaults] valueForKey:PREF_USER_EMAIL];
    
    masterVC.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithTitle:@"<"
                                                                                style:UIBarButtonItemStylePlain
                                                                               target:self
                                                                               action:@selector(customBackButtonPressed)];
    
    
    masterVC.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(nextPage)];
    
    masterVC.navigationItem.title = @"Nedelja";
    self.pControl.selectedSegmentIndex = 6;
    
    self.vremeDFiled.userInteractionEnabled = NO;
    self.vremeUFiled.userInteractionEnabled = NO;
    self.vremeRFiled.userInteractionEnabled = NO;
    self.vremeU2Filed.userInteractionEnabled = NO;
    self.vremeVFiled.userInteractionEnabled = NO;
    
    self.vremeDFiled.text = masterVC.ishranaDB.vremeDorucka;
    self.vremeUFiled.text = masterVC.ishranaDB.vremeUzine;
    self.vremeRFiled.text = masterVC.ishranaDB.vremeRucka;
    self.vremeU2Filed.text = masterVC.ishranaDB.vremeUzine2;
    self.vremeVFiled.text = masterVC.ishranaDB.vremeVecere;
    
    [self segmentSwitch];
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
    LogI(@"Next button clicked u utorak");
    
    //trim string from edit text
    self.tvDorucak.text = [self.tvDorucak.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    self.tvUzina.text = [self.tvUzina.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    self.tvRucak.text = [self.tvRucak.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    self.tvUzina2.text = [self.tvUzina2.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    self.tvVecera.text = [self.tvVecera.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if([self.tvDorucak.text isEqualToString:@""]){
        [ALERT_PRESENTER presentAlertWithTitle:NSLocalizedString(@"error",nil) message:NSLocalizedString(@"msg_22",nil)];
        return;
    }
    
    if([self.tvUzina.text isEqualToString:@""]){
        [ALERT_PRESENTER presentAlertWithTitle:NSLocalizedString(@"error",nil) message:NSLocalizedString(@"msg_23",nil)];
        return;
    }
    
    if([self.tvRucak.text isEqualToString:@""]){
        [ALERT_PRESENTER presentAlertWithTitle:NSLocalizedString(@"error",nil) message:NSLocalizedString(@"msg_24",nil)];
        return;
    }
    
    if([self.tvUzina2.text isEqualToString:@""]){
        [ALERT_PRESENTER presentAlertWithTitle:NSLocalizedString(@"error",nil) message:NSLocalizedString(@"msg_25",nil)];
        return;
    }
    
    if([self.tvVecera.text isEqualToString:@""]){
        [ALERT_PRESENTER presentAlertWithTitle:NSLocalizedString(@"error",nil) message:NSLocalizedString(@"msg_26",nil)];
        return;
    }
    
    NSDateFormatter *today=[[NSDateFormatter alloc] init];
    [today setDateFormat:@"dd.MM.yyyy. HH:mm:ss"];
    NSString *currentDate = [today stringFromDate:[NSDate date]];
    
    [masterVC.ishranaDB setDatumUnosa:currentDate];
    [masterVC.ishranaDB setNDorucak:self.tvDorucak.text];
    [masterVC.ishranaDB setNUzina:self.tvUzina.text];
    [masterVC.ishranaDB setNRucak:self.tvRucak.text];
    [masterVC.ishranaDB setNUzina2:self.tvUzina2.text];
    [masterVC.ishranaDB setNVecera:self.tvVecera.text];
    [masterVC.ishranaDB setIzabranaIshrana:NO];
    [masterVC.ishranaDB setUserID:userMail];
    
    LogI(@" setovana ishrana za nedelju:   %@", masterVC.ishranaDB.nDorucak);
    LogI(@" setovana ishrana za nedelju:   %@", masterVC.ishranaDB.nUzina);
    LogI(@" setovana ishrana za nedelju:   %@", masterVC.ishranaDB.nRucak);
    LogI(@" setovana ishrana za nedelju:   %@", masterVC.ishranaDB.nUzina2);
    LogI(@" setovana ishrana za nedelju:   %@", masterVC.ishranaDB.nVecera);
    
    
    
    [ALERT_PRESENTER presentAlertControllerWithConfigurationHandler:^(MTAlertDescriptor * descriptor) {
        descriptor.priority = MTAlertPriorityNormal;
        descriptor.title = NSLocalizedString(@"Ime nove ishrane", nil);
        descriptor.cancelTitle = NSLocalizedString(@"Cancel", nil);
        descriptor.otherTitles = @[NSLocalizedString(@"OK", nil)];
        descriptor.alertValidator = [[MTAlertValidator alloc] initWithValidateEmptyAndLenght:YES lenght:NO andCharacterLenght:30];
        [descriptor setTextFieldConfig:^(UITextField *textField) {
            textField.keyboardType = UIKeyboardTypeAlphabet;
            textField.placeholder = NSLocalizedString(@"Unesite naziv ishrane", nil);
        }];
        [descriptor setTapBlock:^(UIAlertController *controller, UIAlertAction *action, NSInteger buttonIndex) {
            if (buttonIndex != MTAlertBlocksCancelButtonIndex) {
                //[welf handleNewSectionOrRoomOkActionWithTextField:controller.textFields.firstObject];

                [masterVC.ishranaDB setIme:controller.textFields.firstObject.text];
                LogI(@" ime ishrane:   %@", controller.textFields.firstObject.text);
                
                [masterVC addIshranaSaveDone];
                
                LogI(@" ime sacuvane ishrane:   %@", controller.textFields.firstObject.text);
                //root page
                [self goToHomeView];

            }
        }];
    }];
    
}

- (void)goToHomeView{
    //[NSThread sleepForTimeInterval:2.0f];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)keyboardWasShown:(NSNotification*)notification
{
    NSDictionary *info = [notification userInfo];
    CGRect keyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    UIEdgeInsets contentInset = self.scrollView.contentInset;
    contentInset.bottom = keyboardRect.size.height;
    self.scrollView.contentInset = contentInset;
}

- (void)keyboardWillBeHidden:(NSNotification*)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
}

#pragma mark TextField Delegates
- (BOOL)textViewShouldReturn:(UITextView *)textView
{
    [textView resignFirstResponder];
    return YES;
}


@end


