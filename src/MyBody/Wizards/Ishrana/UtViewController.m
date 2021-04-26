//
//  UtViewController.m
//  MyBody
//
//  Created by Milovan Tomasevic on 05/11/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//

#import "UtViewController.h"
#import "IshranaMasterViewController.h"

@interface UtViewController (){
    IshranaMasterViewController *masterVC;
}


@end

@implementation UtViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    masterVC = (IshranaMasterViewController*)self.parentViewController;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
     //[self.navigationItem setHidesBackButton:NO animated:YES];
    
    masterVC.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithTitle:@"<"
                                                                                style:UIBarButtonItemStylePlain
                                                                               target:self
                                                                               action:@selector(customBackButtonPressed)];
    
    
    masterVC.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@">"
                                                                                 style:UIBarButtonItemStylePlain
                                                                                target:self
                                                                                action:@selector(nextPage)];
    
    masterVC.navigationItem.title = @"Utorak";
    self.pControl.selectedSegmentIndex = 1;
    
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
    
    [masterVC.ishranaDB setUDorucak:self.tvDorucak.text];
    [masterVC.ishranaDB setUUzina:self.tvUzina.text];
    [masterVC.ishranaDB setURucak:self.tvRucak.text];
    [masterVC.ishranaDB setUUzina2:self.tvUzina2.text];
    [masterVC.ishranaDB setUVecera:self.tvVecera.text];
    
    LogI(@" setovana ishrana za utorak:   %@", masterVC.ishranaDB.uDorucak);
    LogI(@" setovana ishrana za utorak:   %@", masterVC.ishranaDB.uUzina);
    LogI(@" setovana ishrana za utorak:   %@", masterVC.ishranaDB.uRucak);
    LogI(@" setovana ishrana za utorak:   %@", masterVC.ishranaDB.uUzina2);
    LogI(@" setovana ishrana za utorak:   %@", masterVC.ishranaDB.uVecera);
    
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
