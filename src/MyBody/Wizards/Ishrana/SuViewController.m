//
//  SuViewController.m
//  MyBody
//
//  Created by Milovan Tomasevic on 05/11/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//

#import "SuViewController.h"
#import "IshranaMasterViewController.h"

@interface SuViewController (){
    IshranaMasterViewController *masterVC;
}


@end

@implementation SuViewController

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
    
    masterVC.navigationItem.title = @"Subota";
    self.pControl.selectedSegmentIndex = 5;
    
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
    
    [masterVC.ishranaDB setSubDorucak:self.tvDorucak.text];
    [masterVC.ishranaDB setSubUzina:self.tvUzina.text];
    [masterVC.ishranaDB setSubRucak:self.tvRucak.text];
    [masterVC.ishranaDB setSubUzina2:self.tvUzina2.text];
    [masterVC.ishranaDB setSubVecera:self.tvVecera.text];
    
    LogI(@" setovana ishrana za subotu:   %@", masterVC.ishranaDB.subDorucak);
    LogI(@" setovana ishrana za subotu:   %@", masterVC.ishranaDB.subUzina);
    LogI(@" setovana ishrana za subotu:   %@", masterVC.ishranaDB.subRucak);
    LogI(@" setovana ishrana za subotu:   %@", masterVC.ishranaDB.subUzina2);
    LogI(@" setovana ishrana za subotu:   %@", masterVC.ishranaDB.subVecera);
    
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

