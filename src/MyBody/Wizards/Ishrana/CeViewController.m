//
//  CeViewController.m
//  MyBody
//
//  Created by Milovan Tomasevic on 05/11/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//

#import "CeViewController.h"
#import "IshranaMasterViewController.h"

@interface CeViewController (){
    IshranaMasterViewController *masterVC;
}


@end

@implementation CeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    masterVC = (IshranaMasterViewController*)self.parentViewController;
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
    
    masterVC.navigationItem.title = @"Cetvrtak";
    self.pControl.selectedSegmentIndex = 3;
    
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
    
    [masterVC.ishranaDB setCDorucak:self.tvDorucak.text];
    [masterVC.ishranaDB setCUzina:self.tvUzina.text];
    [masterVC.ishranaDB setCRucak:self.tvRucak.text];
    [masterVC.ishranaDB setCUzina2:self.tvUzina2.text];
    [masterVC.ishranaDB setCVecera:self.tvVecera.text];
    
    LogI(@" setovana ishrana za cetvrtak:   %@", masterVC.ishranaDB.cDorucak);
    LogI(@" setovana ishrana za cetvrtak:   %@", masterVC.ishranaDB.cUzina);
    LogI(@" setovana ishrana za cetvrtak:   %@", masterVC.ishranaDB.cRucak);
    LogI(@" setovana ishrana za cetvrtak:   %@", masterVC.ishranaDB.cUzina2);
    LogI(@" setovana ishrana za cetvrtak:   %@", masterVC.ishranaDB.cVecera);
    
    [masterVC nextButtonPressed];
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

