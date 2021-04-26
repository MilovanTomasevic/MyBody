//
//  ThirdPageViewController.m
//  MyBody
//
//  Created by Milovan Tomasevic on 03/11/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//

#import "ThirdPageViewController.h"
#import "MasterViewController.h"
#import "LoginViewController.h"

@interface ThirdPageViewController (){
    MasterViewController *masterVC;
}


@end

@implementation ThirdPageViewController{
    UIAlertController *alert;
    NSArray *sPitanjaList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    masterVC = (MasterViewController*)self.parentViewController;
    [self loadPageView];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    [self.pControl setCurrentPage:2];
    [self loadLeftRightButton];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
//    [masterVC.user setTown:_townField.text];
//    [masterVC.user setPostalCode:_postalCodeField.text];
//    [masterVC.user setAdress:_adressField.text];
//    [masterVC.user setCountry:_countryField.text];
//    [masterVC.user setPhone:_phoneField.text];
}

- (void)loadLeftRightButton{
    
    masterVC.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithTitle:@"<"
                                                                                style:UIBarButtonItemStylePlain
                                                                               target:self
                                                                               action:@selector(customBackButtonPressed)];
    
    
    masterVC.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"done",nil)
                                                                                 style:UIBarButtonItemStylePlain
                                                                                target:self
                                                                                action:@selector(nextPage)];
}

- (void)loadPageView{
    
    CGFloat sirinaPolja = self.view.frame.size.width * 0.7;
    int visinaPolja = 45;

    
    self.telefonField =        [[MTFansyTextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - sirinaPolja/2, CGRectGetMaxY(self.pControl.frame), sirinaPolja, visinaPolja)];
    
    self.btnSelection =  [MTButton customizeButtonWithArrow:NSLocalizedString(@"Sigurnosno pitanje", nil) withFrame:CGRectMake(self.view.frame.size.width/2 - sirinaPolja/2, CGRectGetMaxY(self.telefonField.frame)+kMarginDefault/2 , sirinaPolja, visinaPolja)];
    [self.btnSelection addTarget:self action:@selector(onButtonFuncClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnSelection];
    
    self.sOdgovorField =      [[MTFansyTextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - sirinaPolja/2, CGRectGetMaxY(self.btnSelection.frame)+kMarginDefault/2 , sirinaPolja, visinaPolja)];

    [self.telefonField customizeFansyField:self.telefonField withView:self.view andPlaceholder:NSLocalizedString(@"plsh_4a",nil) border:YES radius:YES changeColoc:YES];

    [self.sOdgovorField customizeFansyField:self.sOdgovorField withView:self.view andPlaceholder:NSLocalizedString(@"plsh_4b",nil) border:YES radius:YES changeColoc:YES];
    
    sPitanjaList = [NSArray arrayWithObjects: NSLocalizedString(@"p1", nil), NSLocalizedString(@"p2", nil), NSLocalizedString(@"p3", nil), NSLocalizedString(@"p4", nil), NSLocalizedString(@"p5", nil), NSLocalizedString(@"p6", nil), NSLocalizedString(@"p7", nil), nil];
    
}

-(void)customBackButtonPressed
{
    [masterVC customBackButtonPressed];
}

-(void)nextPage
{
    LogI(@"Next button clicked 3 Page view");
    
    self.telefonField.text = [self.telefonField.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    self.sOdgovorField.text = [self.sOdgovorField.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    //self.btnSelection.titleLabel.text = [self.btnSelection.titleLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([self.telefonField.text isEqualToString:@""]){
        [ALERT_PRESENTER presentAlertWithTitle:NSLocalizedString(@"error",nil) message:NSLocalizedString(@"msg_4a",nil)];
        return;
    }
    if([self.btnSelection.currentTitle isEqualToString:@"Sigurnosno pitanje"]){
        [ALERT_PRESENTER presentAlertWithTitle:NSLocalizedString(@"error",nil) message:NSLocalizedString(@"msg_4b",nil)];
        return;
    }
    if ([self.sOdgovorField.text isEqualToString:@""]) {
        [ALERT_PRESENTER presentAlertWithTitle:NSLocalizedString(@"error",nil) message:NSLocalizedString(@"msg_4c",nil)];
        return;
    }

    [masterVC.user setTelefon:self.telefonField.text];
    [masterVC.user setSPitanje:self.btnSelection.titleLabel.text];
    [masterVC.user setSOdgovor:self.sOdgovorField.text];

    [masterVC addAccountSaveDone];
    
    //root page
    //[self.navigationController popToRootViewControllerAnimated:YES];
    
    //login
    LoginViewController *lvc = [[LoginViewController alloc] init];
    [lvc setTitle:[NSString stringWithFormat:NSLocalizedString(@"log_and_reg",nil)]];
    [self.navigationController pushViewController:lvc animated:YES];
    
}


- (void)onButtonFuncClicked:(UIButton *)sender{
    
    [self.view endEditing:YES];
    
    alert =[UIAlertController
            alertControllerWithTitle:NSLocalizedString(@"Izaberite pitanje", nil)
            message:nil
            preferredStyle:UIAlertControllerStyleActionSheet ];
    
    for (int i =0 ; i<sPitanjaList.count; i++)
    {
        NSString *titleString = sPitanjaList[i];
        UIAlertAction *action = [UIAlertAction actionWithTitle:titleString style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            //[self onFunctionSelected:(int)i];
            [self.btnSelection setTitle:titleString forState:UIControlStateNormal];
            [alert dismissViewControllerAnimated:YES completion:nil];
            alert = nil;
        }];
        
        [alert addAction:action];
    }

    UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"cancel",nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction*  action){
        [alert dismissViewControllerAnimated:YES completion:nil];
        alert = nil;
    }];
    [alert addAction:cancel];
    [self presentViewController:alert animated:NO completion:nil];
}

- (void)onFunctionSelected:(int)index{
    self.btnSelection.titleLabel.text = (sPitanjaList[index]);
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
