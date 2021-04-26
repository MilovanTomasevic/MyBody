//
//  LoginViewController.h
//  MyBody
//
//  Created by Milovan Tomasevic on 01/11/2017.
//  Copyright © 2017 Milovan Tomasevic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (nonatomic, strong) IBOutlet MTTextField *emailLoginField;
@property (nonatomic, strong) IBOutlet MTTextField *passwordLoginField;

@property (nonatomic, strong) IBOutlet UIButton *buttonLogin;
@property (nonatomic, strong) IBOutlet UIButton *buttonRegistar;

@property (nonatomic, strong) IBOutlet UIButton *forgotPassword;


@end
