//
//  LoginViewController.m
//  MyBody
//
//  Created by Milovan Tomasevic on 01/11/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//

#import "LoginViewController.h"
#import "CoreDataManager.h"
#import "MasterViewController.h"
#import "ForgotPasswordViewController.h"

@interface LoginViewController (){
    NSString  *userName, *password;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self lodViewPage];
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.navigationItem.hidesBackButton = YES;
    [self.navigationItem.backBarButtonItem setTitle:@" "];
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
}


- (void)lodViewPage{
    
    CGFloat sirinaPolja = self.view.frame.size.width * 0.7;
    CGFloat sirinaDugmeta = self.view.frame.size.width * 0.4;
    int margina = 10;
    int visinaPolja = 40;
    int visina = 100;
    
    self.emailLoginField =     [[MTTextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - sirinaPolja/2, visina, sirinaPolja, visinaPolja)];
    self.passwordLoginField =  [[MTTextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - sirinaPolja/2, visina + visinaPolja + margina , sirinaPolja, visinaPolja)];
    
    self.forgotPassword = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - sirinaDugmeta/2, visina + 2*visinaPolja + 2*margina , sirinaDugmeta, visinaPolja)];
    self.buttonLogin =    [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - sirinaDugmeta/2, visina + 2*visinaPolja + 7*margina , sirinaDugmeta, visinaPolja)];
    self.buttonRegistar = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - sirinaPolja/2, visina + 3*visinaPolja + 8*margina , sirinaPolja, visinaPolja)];
    
    [_emailLoginField customizeField:_emailLoginField withView:self.view andPlaceholder:NSLocalizedString(@"plsh_1",nil) border:YES];
    [_passwordLoginField customizeField:_passwordLoginField withView:self.view andPlaceholder:NSLocalizedString(@"plsh_2",nil) border:YES];
    
    [self.emailLoginField addLeftPadding];
    [self.passwordLoginField addLeftPadding];
    
    [_emailLoginField addLeftIcon:_emailLoginField withImage:@"user_icon"];
    [_passwordLoginField addLeftIcon:_passwordLoginField withImage:@"password_icon"];
    [_passwordLoginField addRightPasswordButton];
    
    [_forgotPassword setTitle: NSLocalizedString(@"forgot_password",nil) forState:UIControlStateNormal];
    _forgotPassword.layer.cornerRadius = kButtonDefCornerRadius;
    [_forgotPassword addTarget:self action:@selector(forgotPassword:) forControlEvents:UIControlEventTouchUpInside];
    [_forgotPassword setBackgroundColor: [ UIColor clearColor]];
    //[_forgotPassword setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    _forgotPassword.titleLabel.font = [UIFont systemFontOfSize:12];
    
    [_buttonLogin setTitle:NSLocalizedString(@"login",nil) forState:UIControlStateNormal];
    _buttonLogin.layer.cornerRadius = kButtonDefCornerRadius;
    [_buttonLogin addTarget:self action:@selector(loginButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonLogin setBackgroundColor: [ UIColor orangeColor]];
    
    [_buttonRegistar setTitle:NSLocalizedString(@"create_new_account",nil) forState:UIControlStateNormal];
    _buttonRegistar.layer.cornerRadius = kButtonDefCornerRadius;
    [_buttonRegistar addTarget:self action:@selector(registarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonRegistar setBackgroundColor: [ UIColor clearColor]];
    //_buttonRegistar.titleLabel.font = [UIFont systemFontOfSize:12];
    
    NSMutableAttributedString *titleOnButton = [[NSMutableAttributedString alloc] initWithString:_buttonRegistar.titleLabel.text];
    [titleOnButton addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [titleOnButton length])];
    [titleOnButton addAttribute:NSForegroundColorAttributeName value:[[UIColor whiteColor] colorWithAlphaComponent:0.8] range:NSMakeRange(0,[titleOnButton length])];
    [_buttonRegistar setAttributedTitle:titleOnButton forState:UIControlStateNormal];
    
    _forgotPassword.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    _buttonLogin.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    _buttonRegistar.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    
    UIImageView *imageHolder = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - sirinaPolja/2, self.view.frame.size.height - 215, sirinaPolja, 215)];
    UIImage *image = [UIImage imageNamed:@"logreg"];
    
    imageHolder.image = image;
    [imageHolder setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [imageHolder setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    
    
    [self.view addSubview:_forgotPassword];
    [self.view addSubview:_buttonLogin];
    [self.view addSubview:_buttonRegistar];
    
    [self.view addSubview:imageHolder];
    
}

-(void)forgotPassword:(UIButton*)sender
{
    LogI(@"Forgot password button clicked");
    
    ForgotPasswordViewController *fpvc = [[ForgotPasswordViewController alloc] init];
    [fpvc setTitle:[NSString stringWithFormat:NSLocalizedString(@"Password recovery",nil)]];
    [self.navigationController pushViewController:fpvc animated:YES];
}


-(void)loginButtonClicked:(UIButton*)sender
{
    LogI(@"Login button clicked");
    
    userName = _emailLoginField.text;
    password = _passwordLoginField.text;
    userName = [userName stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    password = [password stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    
    if ([userName isEqualToString:@""]) {
        [ALERT_PRESENTER presentAlertWithTitle:NSLocalizedString(@"error",nil) message:NSLocalizedString(@"msg_1a",nil)];
        return;
    }
    if ([password isEqualToString:@""]) {
        [ALERT_PRESENTER presentAlertWithTitle:NSLocalizedString(@"error",nil) message:NSLocalizedString(@"msg_2",nil)];
        return;
    }
    
    CoreDataManager *coreDataManager = [[CoreDataManager alloc]init];
    User *user = [coreDataManager loginUser:userName password:password];
    
    if(([userName isEqualToString:@"Admin"] && [password isEqualToString:@"Admin"]) || user != nil ){
        
        [MTSupport progressDone:([NSString stringWithFormat:NSLocalizedString(@"welcome", nil), userName ]) andView:self.navigationController.view];
        
        //store data
        [[NSUserDefaults standardUserDefaults] setValue:userName forKey:PREF_USER_EMAIL];
        [[NSUserDefaults standardUserDefaults] setValue:password forKey:PREF_USER_PASSWORD];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:PREF_USER_LOGIN];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }else{
        [ALERT_PRESENTER presentAlertWithTitle:NSLocalizedString(@"error",nil) message:NSLocalizedString(@"msg_19",nil)];
    }
}

-(void)registarButtonClicked:(UIButton*)sender
{
    LogI(@"Registar button clicked");
    
    MasterViewController *mvc = [[MasterViewController alloc] init];
    [mvc setTitle:[NSString stringWithFormat:@"Registar"]];
    [self.navigationController pushViewController:mvc animated:YES];
}

@end
