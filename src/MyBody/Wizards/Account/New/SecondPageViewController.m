//
//  SecondPageViewController.m
//  MyBody
//
//  Created by Milovan Tomasevic on 03/11/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//

#import "SecondPageViewController.h"
#import "ThirdPageViewController.h"
#import "MasterViewController.h"

@interface SecondPageViewController (){
    MasterViewController *masterVC;
}
@end

@implementation SecondPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    masterVC = (MasterViewController*)self.parentViewController;
    [self loadPageView];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    [self.pControl setCurrentPage:1];
    [self loadLeftRightButton];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
//    [masterVC.user setFirstName:_firstNameField.text];
//    [masterVC.user setLastName:_lastNameField.text];
//    [masterVC.user setMiddleName:_middleNameField.text];
//    [masterVC.user setDateOfBirth:_dateOfBirthField.text];
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

- (void)loadPageView{
    
    CGFloat sirinaPolja = self.view.frame.size.width * 0.7;
    int visinaPolja = 45;
    
    self.imeField =   [[MTFansyTextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - sirinaPolja/2, CGRectGetMaxY(self.pControl.frame), sirinaPolja, visinaPolja)];
    self.prezimeField =    [[MTFansyTextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - sirinaPolja/2, CGRectGetMaxY(self.imeField.frame)+kMarginDefault/2, sirinaPolja, visinaPolja)];
    self.adresaField =  [[MTFansyTextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - sirinaPolja/2, CGRectGetMaxY(self.prezimeField.frame)+kMarginDefault/2 , sirinaPolja, visinaPolja)];
    self.gradField = [[MTFansyTextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - sirinaPolja/2, CGRectGetMaxY(self.adresaField.frame)+kMarginDefault/2 , sirinaPolja, visinaPolja)];
    self.pKodField = [[MTFansyTextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - sirinaPolja/2, CGRectGetMaxY(self.gradField.frame)+kMarginDefault/2 , sirinaPolja, visinaPolja)];

    [self.imeField customizeFansyField:self.imeField withView:self.view andPlaceholder:NSLocalizedString(@"plsh_3a",nil) border:YES radius:YES changeColoc:YES];
    [self.prezimeField customizeFansyField:self.prezimeField withView:self.view andPlaceholder:NSLocalizedString(@"plsh_3b",nil) border:YES radius:YES changeColoc:YES];
    [self.adresaField customizeFansyField:self.adresaField withView:self.view andPlaceholder:NSLocalizedString(@"plsh_3c",nil) border:YES radius:YES changeColoc:YES];
    [self.gradField customizeFansyField:self.gradField withView:self.view andPlaceholder:NSLocalizedString(@"plsh_3d",nil) border:YES radius:YES changeColoc:YES];
    [self.pKodField customizeFansyField:self.pKodField withView:self.view andPlaceholder:NSLocalizedString(@"plsh_3e",nil) border:YES radius:YES changeColoc:YES];
    
}

-(void)customBackButtonPressed
{
    [masterVC customBackButtonPressed];
}

-(void)nextPage
{
    LogI(@"Next button clicked 2 Page view");
    //next page
    
    self.imeField.text = [self.imeField.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    self.prezimeField.text = [self.prezimeField.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    self.adresaField.text = [self.adresaField.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    self.gradField.text = [self.gradField.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    self.pKodField.text = [self.pKodField.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    
    if ([self.imeField.text isEqualToString:@""]){
        [ALERT_PRESENTER presentAlertWithTitle:NSLocalizedString(@"error",nil) message:NSLocalizedString(@"msg_3a",nil)];
        return;
    }
    if([self.prezimeField.text isEqualToString:@""]){
        [ALERT_PRESENTER presentAlertWithTitle:NSLocalizedString(@"error",nil) message:NSLocalizedString(@"msg_3b",nil)];
        return;
    }
    if ([self.adresaField.text isEqualToString:@""]) {
        [ALERT_PRESENTER presentAlertWithTitle:NSLocalizedString(@"error",nil) message:NSLocalizedString(@"msg_3c",nil)];
        return;
    }
    if ([self.gradField.text isEqualToString:@""]) {
        [ALERT_PRESENTER presentAlertWithTitle:NSLocalizedString(@"error",nil) message:NSLocalizedString(@"msg_3d",nil)];
        return;
    }
    if ([self.pKodField.text isEqualToString:@""]) {
        [ALERT_PRESENTER presentAlertWithTitle:NSLocalizedString(@"error",nil) message:NSLocalizedString(@"msg_3e",nil)];
        return;
    }
    
    [masterVC.user setIme:self.imeField.text];
    [masterVC.user setPrezime:self.prezimeField.text];
    [masterVC.user setAdresa:self.adresaField.text];
    [masterVC.user setGrad:self.gradField.text];
    [masterVC.user setPostanskiKod:self.pKodField.text];
    
    [masterVC nextButtonPressed];
    
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
