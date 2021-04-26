//
//  FirstPageViewController.m
//  MyBody
//
//  Created by Milovan Tomasevic on 03/11/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//

#import "FirstPageViewController.h"
#import "SecondPageViewController.h"
#import "MasterViewController.h"

@interface FirstPageViewController (){
    MasterViewController *masterVC;
}

@end

@implementation FirstPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    masterVC = (MasterViewController*)self.parentViewController;
    [self loadViewPage];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    [self.pControl setCurrentPage:0];
    [self loadLeftRightButton];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [masterVC.user setEmail:_emailField.text];
//    [masterVC.user setPassword:_passwordField.text];
    
}

- (void)loadLeftRightButton{
    
    masterVC.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithTitle:@"<"
                                                                                style:UIBarButtonItemStylePlain
                                                                               target:self
                                                                               action:@selector(customBackButtonPressed)];
    
    masterVC.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@">"
                                                                                 style:UIBarButtonItemStylePlain
                                                                                target:self
                                                                                action:@selector(nextPage)];
    
}


-(void)customBackButtonPressed
{
    [masterVC customBackButtonPressed];
}

-(void)nextPage
{
    LogI(@"Next button clicked 1 Page view");
    
    if (![MTSupport validateEmail:_emailField.text]) {
        [ALERT_PRESENTER presentAlertWithTitle:NSLocalizedString(@"error",nil) message:NSLocalizedString(@"msg_1",nil)];
        return;
    }
    
    if (![_passwordField.text isEqualToString:_passwordRepeatField.text]) {
        [ALERT_PRESENTER presentAlertWithTitle:NSLocalizedString(@"error",nil) message:NSLocalizedString(@"msg_2a",nil)];
        return;
    }
    
    //trim string from edit text
    _emailField.text = [_emailField.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    _passwordField.text = [_passwordField.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    _passwordRepeatField.text = [_passwordRepeatField.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    
    
    [masterVC.user setMail:_emailField.text];
    [masterVC.user setSifra:_passwordField.text];

    LogI(@" setovani mail:   %@ i pass %@", masterVC.user.mail, masterVC.user.sifra);
    
    [masterVC nextButtonPressed];
}


-(void) loadViewPage{
    CGFloat sirinaPolja = self.view.frame.size.width * 0.7;
    int visinaPolja = 40;
    
    self.emailField =          [[MTTextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - sirinaPolja/2, CGRectGetMaxY(self.pControl.frame), sirinaPolja, visinaPolja)];
    self.passwordField =       [[MTTextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - sirinaPolja/2, CGRectGetMaxY(self.emailField.frame)+kMarginDefault/2, sirinaPolja, visinaPolja)];
    self.passwordRepeatField = [[MTTextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - sirinaPolja/2, CGRectGetMaxY(self.passwordField.frame)+kMarginDefault/2, sirinaPolja, visinaPolja)];
    
    [_emailField customizeField:_emailField withView:self.view andPlaceholder:NSLocalizedString(@"plsh_1",nil) border:YES];
    [_passwordField customizeField:_passwordField withView:self.view andPlaceholder:NSLocalizedString(@"plsh_2",nil) border:YES];
    [_passwordRepeatField customizeField:_passwordRepeatField withView:self.view andPlaceholder:NSLocalizedString(@"plsh_2a",nil) border:YES];
    
    [self.emailField addLeftIcon:self.emailField withImage:@"user_icon"];
    [self.passwordField addLeftIcon:self.passwordField withImage:@"password_icon"];
        [self.passwordField addRightPasswordButton];
    [self.passwordRepeatField addLeftIcon:self.passwordRepeatField withImage:@"password_icon"];
    [self.passwordRepeatField addRightPasswordButton];
    

}

-(void)swipeleft:(UISwipeGestureRecognizer*)gestureRecognizer
{
    [self nextPage];
}

-(void)swiperight:(UISwipeGestureRecognizer*)gestureRecognizer
{
    [self customBackButtonPressed];
}

@end
